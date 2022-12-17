import math

proc linear*[T] (t, b, d, e: T): T =
  d * t / e + b

proc inQuad*[T] (t, b, d, e: T): T =
  d * pow(t/e, 2.0) + b

proc outQuad*[T] (t, b, d, e: T): T =
  let t2 = (t/e)
  result = -d * t2 * (t2 - T(2)) + b

proc inOutQuad*[T] (t, b, d, e: T): T =
  let t2 = (t / e) * T(2)
  result =
    if t2 < T(1): d / T(2) * pow(t2, 2) + b
    else: -d / 2 * ((t2 - 1) * (t2 - 3) - 1) + b

proc inCubic*[T] (t, b, d, e: T): T =
  result = d * pow(t / e, T(3)) + b

proc outCubic*[T] (t, b, d, e: T): T =
  d * (pow(t / e - 1, T(3)) + 1) + b

proc inOutCubic*[T] (t, b, d, e: T): T =
  let
    t2 = t / e * 2
    tm = t2 - 2

  result =
    if t2 < 1: d * 0.5 * t2 * t2 * t2 + b
    else: d * 0.5 * (tm * tm * tm + 2) + b

proc inQuart*[T] (t, b, d, e: T): T =
  d * pow(t / e, 4) + b

proc outQuart*[T] (t, b, d, e: T): T =
  -d * (pow(t / e - 1, 4) - 1) + b

proc inOutQuart*[T] (t, b, d, e: T): T =
  let t2 = t / e * 2
  result =
    if t2 < 1: d * 0.5 * pow(t2, 4) + b
    else: -d * 0.5 * (pow(t2 - 2, 4) - 2) + b
