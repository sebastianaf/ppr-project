import React from "react";

const DasboardLayout = () => {
  return (
    <div className={`flex justify-center items-start w-full`}>
      <div className={`flex flex-row flex-wrap max-w-[1280px] w-full`}>
        <div
          className={`p-1 md:p-2 w-full  h-[300px] md:h-[400px] lg:h-[500px] `}
        >
          <div
            className={`w-full h-full shadow border rounded-lg  overflow-hidden`}
          ></div>
        </div>
        <div
          className={`p-1 md:p-2 w-full h-[300px] md:h-[400px] lg:h-[500px] `}
        >
          <div
            className={`w-full h-full shadow border rounded-lg  overflow-hidden`}
          ></div>
        </div>
      </div>
    </div>
  );
};

export default DasboardLayout;
