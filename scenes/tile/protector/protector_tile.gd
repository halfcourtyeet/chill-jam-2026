class_name ProtectorTile extends TileEntity

func _on_timer_timeout():
    $BulletStopActiveTimer.start()
    $Area2D/CollisionShape2D.disabled = false

func _on_bullet_stop_active_timer_timeout() -> void:
    $Area2D/CollisionShape2D.disabled = true
