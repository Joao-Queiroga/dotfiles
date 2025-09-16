import { dismissAllNotifications, dismissLastNotification } from "../widget/Notifications";

export const requestHandler = (argv: string[], res: (res: any) => void) => {
  const [cmd, arg, ...rest] = argv;
  if (cmd === "clearLastNotification") {
    dismissLastNotification();
    res("ok");
  }
  if (cmd === "clearAllNotifications") {
    dismissAllNotifications();
    res("ok");
  }
};
