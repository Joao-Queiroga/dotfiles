import { allNotifications } from "../widget/Notifications";

export const requestHandler = (request: string, res: (res: any) => void) => {
  if (request == "clearLastNotification") {
    allNotifications.dismissLastNotification();
    res("ok");
  }
  if (request == "clearAllNotifications") {
    allNotifications.dismissAllNotifications();
    res("ok");
  }
};
