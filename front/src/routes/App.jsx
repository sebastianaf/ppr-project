import React from "react";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";

import ProtectedRoute from "./ProtectedRoute";
import Login from "../pages/Login";
import Dashboart from "../pages/Dashboart";
import Page404 from "../pages/Page404";
import Practice from "../pages/Practice";
import DefaultLayout from "../components/DefaultLayout";

const App = () => (
  <BrowserRouter>
    <Routes>
      <Route exact path="/login" element={<Login />} />
      <Route exact path="/practice" element={<Practice />} />
      <Route exact path="/dashboard" element={<Dashboart />} />
      <Route exact path="/" element={<Navigate to={`/dashboard`} />} />
      <Route path="*" element={<Page404 />} />
    </Routes>
  </BrowserRouter>
);

export default App;
