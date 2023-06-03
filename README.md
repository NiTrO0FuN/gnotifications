
# Garry's mod addon that replaces notifications for DarkRP events.

---






## Easy to use serverside API to send a notification:

#### Send a notification to a particular player

```lua
  GNotifications.sendNotification(ply, nType, message, playSound)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `ply` | `Entity` | **Required**. Player to send notification to |
| `nType` | `Number` | **Required**. [Notification type](#notification-types) |
| `message` | `string` | **Required**. Notification content |
| `playSound` | `Number` | **Optional=1**. 0 to mute the sound |

#### Broadcast a notification to all players

```lua
  GNotifications.sendBroadcastNotification(nType, message, playSound)
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `nType` | `Number` | **Required**. [Notification type](#notification-types) |
| `message` | `string` | **Required**. Notification content |
| `playSound` | `Number` | **Optional=1**. 0 to mute the sound |


### Notification types

```
GNotifications.TYPE_INFORMATION = 0
GNotifications.TYPE_ERROR = 1
GNotifications.TYPE_IMPORTANT = 2
GNotifications.TYPE_VALIDATION = 3
GNotifications.TYPE_NORMAL = 4
```


