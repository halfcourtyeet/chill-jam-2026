class_name BombTile extends TileEntity

signal explode

func splode():
    explode.emit()

func beep():
    stop()
    play("default")
    $BombNoises.play()
