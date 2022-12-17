# Tweenim - a simple tween library

## Installation

`nimble install "https://github.com/SkyVault/tweenim"`

## Example

```nim
import boxy, windy, opengl, tweenim

when isMainModule:
  let window = newWindow("dev", ivec2(1280, 720))
  makeContextCurrent(window)

  loadExtensions()

  let bxy = newBoxy()

  let img = newImage(50, 50)

  let ctx = newContext(img)
  ctx.fillStyle = rgba(255, 255, 255, 255)
  ctx.fillRoundedRect(rect(vec2(0, 0), vec2(50, 50)), 8)

  const duration = 20.0

  var tweens = @[
    newTween[float](0.0, 600.0, duration, linear),
    newTween[float](0.0, 600.0, duration, inQuad),
    newTween[float](0.0, 600.0, duration, outQuad),
    newTween[float](0.0, 600.0, duration, inOutQuad),
    newTween[float](0.0, 600.0, duration, inCubic),
    newTween[float](0.0, 600.0, duration, outCubic),
    newTween[float](0.0, 600.0, duration, inOutCubic),
    newTween[float](0.0, 600.0, duration, inQuart),
    newTween[float](0.0, 600.0, duration, outQuart),
    newTween[float](0.0, 600.0, duration, inOutQuart),
    newTween[float](0.0, 600.0, duration, inQuint),
    newTween[float](0.0, 600.0, duration, outQuint),

    newTween[float](0.0, 600.0, duration, inExpo),
    newTween[float](0.0, 600.0, duration, outExpo),
    newTween[float](0.0, 600.0, duration, inOutExpo),

    newTween[float](0.0, 600.0, duration, inCirc),
    newTween[float](0.0, 600.0, duration, outCirc),
    newTween[float](0.0, 600.0, duration, inOutCirc),
  ]

  bxy.addImage("rect", img)

  window.onFrame = proc() =
    bxy.beginFrame(window.size)
    var i = 0
    for t in tweens.mitems:
      bxy.drawImage("rect", vec2(20 + t.value, 20 + i.float * 25), tint = color(
          1.0, 1.0, 0.2 + (i.float / len(tweens).float) * 0.8, 1.0))
      t.update(0.1)
      inc(i)
    bxy.endFrame()

    window.swapBuffers()

  while not window.closeRequested:
    pollEvents()
```