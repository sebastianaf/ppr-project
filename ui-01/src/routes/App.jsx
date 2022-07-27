import React, { useEffect, Suspense } from "react";

import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";

import check from "../tools/check";

//Redux
import { connect } from "react-redux";
import { setUser } from "../actions";

import Spinner from "../components/Spinner";

const Login = React.lazy(() => import("../pages/Login"));
const Compute1 = React.lazy(() => import("../pages/Compute1"));
const Compute2 = React.lazy(() => import("../pages/Compute1"));
const Page404 = React.lazy(() => import("../pages/Page404"));

const App = (props) => {
  const { setUser } = props;

  useEffect(() => {
    const checking = async () => {
      const user = await check();
      setUser(user);
    };
    checking();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <BrowserRouter>
      <Suspense
        fallback={
          <div className="flex justify-center items-center h-screen bg-slate-100">
            <Spinner loading />
            <div className="text-xl">Loading...</div>
          </div>
        }
      >
        <Routes>
          <Route exact path={`/login`} element={<Login />} />
          <Route exact path={`/compute1`} element={<Compute1 />} />
          <Route exact path={`/compute2`} element={<Compute2 />} />

          {/* Route corrections */}
          <Route exact path={`/`} element={<Navigate to={`/compute1`} />} />
          <Route path={`*`} element={<Page404 />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
};

const mapState = (state) => {
  return {
    user: state.user,
  };
};

const mapProps = {
  setUser,
};

export default connect(mapState, mapProps)(App);
