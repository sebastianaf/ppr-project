import React from "react";
import Sidebar from "./Sidebar";
import Header from "./Header";

//Redux
import { connect } from "react-redux";

const DefaultLayout = (props) => {
  const { children, user } = props;
  return user.name ? (
    <div className="flex flex-row">
      <Sidebar />
      <div className="grow flex flex-col h-screen bg-white w-full">
        <Header />
        <div className="overflow-x-hidden overflow-y-auto p-4">{children}</div>
      </div>
    </div>
  ) : (
    <>{children}</>
  );
};

const mapState = (state) => {
  return {
    user: state.user,
  };
};

export default connect(mapState, null)(DefaultLayout);
