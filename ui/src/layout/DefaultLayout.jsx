import React from "react";
import Sidebar from "../components/Sidebar";
import Header from "../components/Header";
import Footer from "../components/Footer";
import { Transition } from "@headlessui/react";

const DefaultLayout = (props) => {
  const { children } = props;
  return (
    <div className={`flex flex-row`}>
      <Sidebar />
      <div
        className={`flex flex-col bg-white w-full min-h-screen max-h-screen`}
      >
        <Header />

        <Transition
          className={`flex justify-center flex-grow items-start overflow-x-hidden overflow-y-auto p-1 md:p-5 bg-slate-100`}
          show
          enter="transition ease-out duration-500"
          enterFrom="transform opacity-0 scale-95"
          enterTo="transform opacity-100 scale-100"
          leave="transition ease-in duration-500"
          leaveFrom="transform opacity-100 scale-100"
          leaveTo="transform opacity-0 scale-95"
        >
          {children}
        </Transition>

        <Footer />
      </div>
    </div>
  );
};

export default DefaultLayout;
