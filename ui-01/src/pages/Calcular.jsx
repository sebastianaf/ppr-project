import React from "react";
import DefaultLayout from "../layout/DefaultLayout";
import ProtectedRoute from "../routes/ProtectedRoute";
import ComputeLayout from "../layout/ComputeLayout";

const Compute = () => {
  return (
    <ProtectedRoute>
      <DefaultLayout>
        <ComputeLayout />
      </DefaultLayout>
    </ProtectedRoute>
  );
};
export default Compute;
