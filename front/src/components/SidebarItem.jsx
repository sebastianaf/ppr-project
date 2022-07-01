import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Link } from "react-router-dom";

//Redux
import { connect } from "react-redux";

const SidebarItem = (props) => {
  const { data, open } = props;
  return (
    <Link to={props.data.to}>
      <li
        className={`flex items-center px-2 py-3 my-2 bg-slate-600 hover:bg-cyan-500 cursor-pointer duration-500 rounded-md`}
      >
        <FontAwesomeIcon className="text-slate-200 mx-2" icon={data.icon} />
        <div
          className={`${!open && `opacity-0 scale-0`} font-light duration-500`}
        >
          {props.data.title}
        </div>
      </li>
    </Link>
  );
};

const mapStateToProps = (state) => {
  return {
    open: state.open,
  };
};

export default connect(mapStateToProps, null)(SidebarItem);
