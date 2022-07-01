import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBars, faUser } from "@fortawesome/free-solid-svg-icons";
import "../styles/Practice.css";

//Redux
import { connect } from "react-redux";
import { setHideSidebar } from "../actions";

const Header = (props) => {
  const { hideSidebar, user } = props;
  //pending
  console.log(hideSidebar);
  return (
    <>
      <div className="flex justify-between items-center p-2 bg-slate-300 h-[70px] shadow-lg">
        <FontAwesomeIcon
          icon={faBars}
          className="icon cursor-pointer mx-2 md:invisible"
          onClick={() => {
            setHideSidebar(!hideSidebar);
          }}
        />
        <div className="flex justify-center items-center px-2 py-1 rounded-md cursor-pointer hover:bg-slate-200 bg-slate-300 duration-500">
          <div className="flex flex-col items-end justify-center whitespace-nowrap">
            <div className="m-0 text-left font-semibold">{user.name}</div>
            <div className="mt-[-5px] text-sm text-left">{user.role}</div>
          </div>
          <div className="w-[32px] h-[32px] ml-2 rounded-full border border-slate-50 overflow-hidden flex justify-center items-center">
            <FontAwesomeIcon
              icon={faUser}
              className={`w-[24px] h-[24px] text-slate-400`}
            />
          </div>
        </div>
      </div>
      <div className="overflow-x-hidden overflow-y-auto"></div>
    </>
  );
};

const mapState = (state) => ({
  hideSidebar: state.hideSidebar,
  user: state.user,
});

const mapActions = {
  setHideSidebar,
};

export default connect(mapState, mapActions)(Header);
