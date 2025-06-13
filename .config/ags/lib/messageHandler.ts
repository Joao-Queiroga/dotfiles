import { dismissAllNotifications, dismissLastNotification } from "../widget/Notifications";

export const requestHandler = (request: string, res: (res: any) => void) => {
  if (request === "clearLastNotification") {
    dismissLastNotification();
    res("ok");
  }
  if (request === "clearAllNotifications") {
    dismissAllNotifications();
    res("ok");
  }
};
