import Index from "@/pages/admin/users/Index";

import GroupRoute from "@/routes/admin/GroupRoute";
import UserRoute from "@/routes/admin/UserRoute";

const baseRoutes = [
  { path: "/admin", component: Index, meta: { resource: "User" } },
];

const routes = baseRoutes.concat(GroupRoute, UserRoute);

export default routes;
