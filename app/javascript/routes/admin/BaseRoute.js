import Index from "@/pages/admin/patients/Index";

import ExerciseRoute from "@/routes/admin/ExerciseRoute";
import GroupRoute from "@/routes/admin/GroupRoute";
import UserRoute from "@/routes/admin/UserRoute";
import PatientRoute from "@/routes/admin/PatientRoute";

const baseRoutes = [
  { path: "/admin", component: Index, meta: { resource: "Patient" } },
  { path: "/", component: Index, meta: { resource: "Patient" } }
];

const routes = baseRoutes.concat(
  ExerciseRoute,
  GroupRoute,
  UserRoute,
  PatientRoute
);

export default routes;
