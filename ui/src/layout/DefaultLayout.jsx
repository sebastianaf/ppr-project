import React from "react";
import Sidebar from "../components/Sidebar";
import Header from "../components/Header";
import Footer from "../components/Footer";

const DefaultLayout = (props) => {
  const { children } = props;
  return (
    <div className={`flex flex-row`}>
      <Sidebar />
      <div className={`flex flex-col bg-white w-full min-h-screen max-h-screen`}>
        <Header />
        <div
          className={`flex justify-center flex-grow items-start overflow-x-hidden overflow-y-auto p-1 md:p-5 bg-slate-100`}
        >
          {children}
        </div>
        <Footer />
      </div>
    </div>
  );
};

export default DefaultLayout;
