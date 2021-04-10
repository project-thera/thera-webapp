import Index from "@/pages/admin/exercises/Index";
import New from "@/pages/admin/exercises/New";
import Edit from "@/pages/admin/exercises/Edit";

const exerciseRoutes = [
  {
    path: "/admin/ejercicios",
    name: "admin-exercises",
    component: Index,
    meta: { resource: "Exercise" }
  },
  {
    path: "/admin/ejercicios/crear",
    name: "admin-exercises-new",
    component: New,
    meta: { resource: "Exercise", action: "create" }
  },
  {
    path: "/admin/ejercicios/:id/editar",
    name: "admin-exercises-edit",
    component: Edit,
    meta: { resource: "Exercise", action: "update" }
  }
];

export default exerciseRoutes;
