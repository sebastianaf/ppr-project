import React from "react";
import DefaultLayout from "../layout/DefaultLayout";
import ProtectedRoute from "../routes/ProtectedRoute";
import DashboardLayout from "../layout/DashboardLayout";

const Dashboard = () => {
  return (
    <ProtectedRoute>
      <DefaultLayout>
        <DashboardLayout />
      </DefaultLayout>
    </ProtectedRoute>
  );
};
export default Dashboard;
