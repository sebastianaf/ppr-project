import React from "react";
import DefaultLayout from "../components/DefaultLayout";
import ProtectedRoute from "../routes/ProtectedRoute";

const Dashboart = () => {
  return (
    <ProtectedRoute>
      <DefaultLayout>
        <div>This is the dashboart</div>
      </DefaultLayout>
    </ProtectedRoute>
  );
};
export default Dashboart;
