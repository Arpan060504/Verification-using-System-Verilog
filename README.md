# SystemVerilog Verification — Interview Notes

A compact revision sheet based on the topics covered so far. Examples use standard SystemVerilog syntax. Class-based constrained randomization needs a simulator with suitable support (such as a properly licensed Cadence Xcelium or Questa verification setup). Icarus Verilog has limited support for these features.

## 1. Class and object basics

A class defines properties and methods. An object is created using `new()`.

```systemverilog
class packet;
  bit [7:0] data;
endclass

module tb;
  packet p_h;

  initial begin
    p_h = new();
    p_h.data = 8'hA5;
    $display("data = %0h", p_h.data);
  end
endmodule
```

- `packet p_h;` declares a class handle; it does not create an object.
- `p_h = new();` constructs an object.
- Handle assignment (for example, `p2 = p1;`) copies the handle, not the object. Both handles refer to the same object.

## 2. `rand` and `randomize()`

`rand` marks a property as eligible for randomization. Calling `randomize()` invokes the solver.

```systemverilog
class test;
  rand bit [3:0] a;
endclass

module tb;
  test t_h;

  initial begin
    t_h = new();
    repeat (5) begin
      if (t_h.randomize())
        $display("a = %0d", t_h.a);
      else
        $display("Randomization failed");
    end
    $finish;
  end
endmodule
```

- `randomize()` returns `1` on success and `0` on failure.
- An unsigned `bit [3:0]` can represent 0 through 15.
- `randc` means cyclic randomization: values cycle through the domain before repeating, subject to constraints.

## 3. Constraints

Constraints describe legal values; they are declarative rules, not procedural assignments.

### Inclusive range with `inside`

```systemverilog
constraint range_c {
  a inside {[2:5]};
}
```

This allows 2, 3, 4, and 5. `range` is not a constraint keyword.

Equivalent comparisons:

```systemverilog
constraint range_c {
  a >= 2;
  a <= 5;
}
```

### Divisibility

```systemverilog
constraint multiple_of_3 {
  a % 3 == 0;
}
```

`%` is modulo. A remainder of zero means the value is divisible by 3.

### Constraint conflict

```systemverilog
constraint c1 { a inside {[2:5]}; }
constraint c2 { a inside {[8:12]}; }
```

These hard constraints conflict, so randomization fails: no value satisfies both.

## 4. `soft` constraints

A soft constraint expresses a preference. It may be relaxed when a conflicting hard constraint is present.

```systemverilog
class test;
  rand bit [3:0] a;

  constraint default_c {
    soft a inside {[2:5]};
  }
endclass

module tb;
  test t_h;

  initial begin
    t_h = new();

    // Normally follows the soft preference: 2 through 5
    t_h.randomize();
    $display("Default a = %0d", t_h.a);

    // Inline hard constraint overrides the soft preference
    t_h.randomize() with { a inside {[8:12]}; };
    $display("Inline a = %0d", t_h.a);

    $finish;
  end
endmodule
```

Hard constraints must be satisfied; soft constraints are preferences.

## 5. Conditional constraints

Use `if...else` inside a constraint block to select rules based on a variable.

```systemverilog
class test;
  rand bit mode;
  rand bit [3:0] a;

  constraint mode_c {
    if (mode == 0)
      a inside {[1:5]};
    else
      a inside {[10:15]};
  }
endclass
```

- `mode == 0` → `a` is 1 through 5.
- `mode == 1` → `a` is 10 through 15.

This is declarative, not a procedural `if` that executes statements.

## 6. Inline constraints

An inline constraint is attached to one `randomize()` call using `with`.

```systemverilog
t_h.randomize() with {
  a > 3;
  a < 6;
};
```

The allowed values are 4 and 5. Inline conditions are added to class constraints; conflicting hard conditions can make randomization fail.

## 7. `rand_mode()` vs `constraint_mode()`

### `rand_mode()`

Controls whether a random property participates in randomization.

```systemverilog
t_h.a.rand_mode(0); // Disable randomization of a
t_h.a.rand_mode(1); // Re-enable randomization of a
```

When disabled, `a` keeps its current value. Constraints involving `a` still apply to that fixed value; randomization can fail if it violates them.

### `constraint_mode()`

Enables or disables a named constraint block.

```systemverilog
t_h.range_c.constraint_mode(0); // Disable this constraint
t_h.range_c.constraint_mode(1); // Enable it again
```

- `rand_mode()` → controls a variable's participation.
- `constraint_mode()` → controls whether a constraint block is active.

## 8. Scope randomization: `std::randomize()`

`std::randomize()` can randomize variables declared outside a class.

```systemverilog
module tb;
  bit [3:0] a, b;

  initial begin
    repeat (5) begin
      if (std::randomize(a, b) with {
        a inside {[2:5]};
        b inside {[10:15]};
      })
        $display("a=%0d b=%0d", a, b);
      else
        $display("Randomization failed");
    end
    $finish;
  end
endmodule
```

- `object.randomize()` randomizes the object's `rand` properties.
- `std::randomize(a, b)` randomizes the listed variables in the current scope.
- It returns success (`1`) or failure (`0`).

## 9. `pre_randomize()` and `post_randomize()`

These optional callbacks are invoked automatically around object randomization.

```systemverilog
class test;
  rand bit [1:0] a;

  function void pre_randomize();
    $display("Before randomization: a=%0d", this.a);
  endfunction

  function void post_randomize();
    $display("After successful randomization: a=%0d", this.a);
  endfunction
endclass
```

- `pre_randomize()` runs before the solver randomizes the object.
- `post_randomize()` runs after successful randomization.
- `this.a` refers to property `a` of the current object. Here, `a` alone also works.
- These callbacks are optional; randomization works without them.

## 10. Threads: `fork...join`

`fork` starts concurrent processes. `join` waits until every forked process finishes.

```systemverilog
module tb;
  initial begin
    fork
      begin
        #5;
        $display("Thread 1 at %0t", $time);
      end

      begin
        #10;
        $display("Thread 2 at %0t", $time);
      end

      begin
        #3;
        $display("Thread 3 at %0t", $time);
      end
    join

    $display("All threads done at %0t", $time);
    $finish;
  end
endmodule
```

Expected order: Thread 3 at time 3, Thread 1 at time 5, Thread 2 at time 10, then the parent continues at time 10.

| Construct | When the parent resumes |
|---|---|
| `fork ... join` | After all child threads finish |
| `fork ... join_any` | After the first child thread finishes |
| `fork ... join_none` | Immediately; it does not wait |

With `join_any`, other child threads continue unless explicitly stopped. `$finish` ends the entire simulation.

## 11. Running examples

### Cadence Xcelium

For a file such as `example.sv`:

```bash
xrun -sv example.sv
```

### Questa / ModelSim

```bash
vlog -sv example.sv
vsim -c tb -do "run -all; quit"
```

The testbench top module in these examples is `tb`.

### Icarus Verilog note

Icarus is useful for many basic RTL and procedural examples, but class-based randomization, constraints, and some OOP constructs are not reliably supported. A compilation error in these features may be a simulator limitation rather than invalid SystemVerilog.

## Fast interview revision

- `rand` → eligible for randomization.
- `randomize()` → solve constraints and assign random values; returns 1/0.
- `inside {[L:U]}` → inclusive range.
- `a % N == 0` → multiple of N.
- Hard constraint → mandatory.
- `soft` constraint → preference that may be relaxed.
- `if...else` constraint → conditional rules.
- `randomize() with { ... }` → inline constraint for a call.
- `rand_mode(0/1)` → disable/enable randomization of a property.
- `constraint_mode(0/1)` → disable/enable a constraint block.
- `std::randomize()` → randomize variables in the current scope.
- `pre_randomize()` / `post_randomize()` → optional callbacks.
- `fork...join` → concurrent threads; parent waits for all.
- `fork...join_any` → parent waits for one.
- `fork...join_none` → parent does not wait.
