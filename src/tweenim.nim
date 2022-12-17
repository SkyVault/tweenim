import tables, math

type
  EasingFn = proc(time, begin, delta, elapsed: SomeNumber): SomeNumber
  EasingKind* = enum
    linear

    inQuad
    outQuad
    inOutQuad

    inCubic
    outCubic
    inOutCubic

    inQuart
    outQuart
    inOutQuart

    inQuint
    outQuint
    inOutQuint

    inSine
    outSine
    inOutSine

    inExpo
    outExpo
    inOutExpo

    inCirc
    outCirc
    inOutCirc

    inElastic
    outElastic
    inOutElastic

    inBack
    outBack
    inOutBack

    inBounce
    outBounce
    inOutBounce


  Tween*[T] = object
    time: T
    init, value, target: T
    duration: float
    easing: EasingKind

func value*[T](tween: Tween[T]): T = tween.value

proc newTween*[T](init, target, duration: T, easing: EasingKind): Tween[T] =
  Tween[T](
    init: init,
    value: init,
    target: target,
    duration: duration,
    easing: easing
  )

proc iLinear*[T] (t, b, d, e: T): T =
  d * t / e + b
proc iInQuad*[T] (t, b, d, e: T): T =
  d * pow(t/e, 2.0) + b
proc iOutQuad[T] (t, b, d, e: T): T =
  let t2 = (t/e)
  result = -d * t2 * (t2 - T(2)) + b
proc iInOutQuad[T] (t, b, d, e: T): T =
  let t2 = (t / e) * T(2)
  result =
    if t2 < T(1): d / T(2) * pow(t2, 2) + b
    else: -d / 2 * ((t2 - 1) * (t2 - 3) - 1) + b

proc isDone*[T] (tween: Tween[T]): bool =
  tween.time >= tween.duration

proc interpolate*[T] (tween: var Tween[T]) =
  let
    time = tween.time
    begin = tween.init
    delta = tween.target - tween.init
    elapsed = tween.duration

  tween.value =
    case tween.easing
      of linear: iLinear(time, begin, delta, elapsed)

      of inQuad: iInQuad(time, begin, delta, elapsed)
      of outQuad: iOutQuad(time, begin, delta, elapsed)
      of inOutQuad: iInOutQuad(time, begin, delta, elapsed)
      else:
        tween.value

proc set*[T] (tween: var Tween[T], time: T): bool =
  tween.time = time

  if tween.time <= 0:
    tween.time = 0
    tween.value = tween.target
  elif tween.time >= tween.duration:
    tween.time = tween.duration
  else:
    interpolate(tween)

  result = tween.isDone

proc update*[T] (tween: var Tween[T], deltatime: T): bool {.discardable.} =
  result = tween.set(tween.time + deltatime)
