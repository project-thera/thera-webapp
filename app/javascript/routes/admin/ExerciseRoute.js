import Index from "@/pages/admin/exercises/Index";

const exerciseRoutes = [
  {
    path: "/admin/ejercicios",
    name: "admin-exercises",
    component: Index,
    meta: { resource: "Exercise" },
  },
];

export default exerciseRoutes;
