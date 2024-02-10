import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../view/error_page_view.dart';

class NotificationService {
  Future<void> initializeNotification(Widget? onActionReceivedMethodForPage) async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "high_importance_channel",
          channelName: "Basic Notification",
          channelDescription: "test",
          groupKey: "high_importance_channel",
          defaultColor: const Color(0xff9d50dd),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          criticalAlerts: true,
          onlyAlertOnce: true,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: "high_importance_channel_group",
            channelGroupName: "Group 1")
      ],
      debug: true,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
      if (!isAllowed)
        {AwesomeNotifications().requestPermissionToSendNotifications()}
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) {
        return onActionReceivedMethod(receivedAction, onActionReceivedMethodForPage ?? const ErrorPageView());
      },
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }

  Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction,Widget onActionReceivedMethodForPage) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      Main.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => onActionReceivedMethodForPage,
        ),
      );
    }
  }

  Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("OnDismissActionReceivedMethod");
  }

  Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("OnNotificationCreatedMethod");
  }

  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("OnNotificationDisplayedMethod");
  }

  Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,  // Otomatik olarak benzersiz bir ID oluşturulacak
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
        interval: interval,
        timeZone:
        await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      )
          : null,
    );
    print(await AwesomeNotifications().getLocalTimeZoneIdentifier());
  }
}