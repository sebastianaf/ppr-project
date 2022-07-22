import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBars } from "@fortawesome/free-solid-svg-icons";
import "../styles/index.css";

import DropdownUser from "./DropdownUser";

//Redux
import { connect } from "react-redux";
import { setHideSidebar } from "../actions";

const Header = (props) => {
  const { hideSidebar } = props;
  return (
    <>
      <div
        className={`flex justify-between items-center p-2 bg-slate-200 h-[70px] border`}
      >
        <FontAwesomeIcon
          icon={faBars}
          className={`icon cursor-pointer mx-2 md:invisible`}
          onClick={() => {
            setHideSidebar(!hideSidebar);
          }}
        />
        <DropdownUser />
      </div>
      <div className={`overflow-x-hidden overflow-y-auto`}></div>
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
