import Index from "@/pages/admin/users/Index";

import ExerciseRoute from "@/routes/admin/ExerciseRoute";
import GroupRoute from "@/routes/admin/GroupRoute";
import UserRoute from "@/routes/admin/UserRoute";

const baseRoutes = [
  { path: "/admin", component: Index, meta: { resource: "User" } },
];

const routes = baseRoutes.concat(ExerciseRoute, GroupRoute, UserRoute);

export default routes;
