import Index from "@/pages/admin/patients/Index";

const userRoutes = [
  {
    path: "/admin/pacientes",
    name: "admin-patients",
    component: Index,
    meta: { resource: "User" },
  },
];

export default userRoutes;
