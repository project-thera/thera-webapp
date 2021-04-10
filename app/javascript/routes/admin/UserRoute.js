import Index from "@/pages/admin/users/Index";
import New from "@/pages/admin/users/New";
import Edit from "@/pages/admin/users/Edit";

const userRoutes = [
  {
    path: "/admin/usuarios",
    name: "admin-users",
    component: Index,
    meta: { resource: "User" }
  },
  {
    path: "/admin/usuarios/crear",
    name: "admin-users-new",
    component: New,
    meta: { resource: "User", action: "create" }
  },
  {
    path: "/admin/usuarios/:id/editar",
    name: "admin-users-edit",
    component: Edit,
    meta: { resource: "User", action: "update" }
  }
];

export default userRoutes;
