import React from "react";
import Sidebar from "../components/Sidebar";
import Header from "../components/Header";
import Footer from "../components/Footer";

const DefaultLayout = (props) => {
  const { children } = props;
  return (
    <div className={`flex flex-row`}>
      <Sidebar />
      <div className={`grow flex flex-col h-screen bg-white w-full`}>
        <Header />
        <div
          className={`flex justify-center items-start w-full overflow-x-hidden overflow-y-auto p-1 md:p-2`}
        >
          {children}
        </div>
        <Footer />
      </div>
    </div>
  );
};

export default DefaultLayout;
