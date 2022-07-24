import React, { useState } from "react";
import { Transition } from "@headlessui/react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlay } from "@fortawesome/free-solid-svg-icons";

import DefaultLayout from "../layout/DefaultLayout";
import ProtectedRoute from "../routes/ProtectedRoute";
import ComputeLayout from "../layout/ComputeLayout";
import Spinner from "../components/Spinner";
import errorCodes from "../config/errorCodes";
import api2 from "../config/api2";

//Redux
import { connect } from "react-redux";
import { setModalOpen, setModalOptions } from "../actions";

const Compute = (props) => {
  const { setModalOpen, setModalOptions } = props;
  const [params, setParams] = useState("");
  const [calc, setCalc] = useState(false);
  const [loading, setLoading] = useState(false);
  return (
    <ProtectedRoute>
      <DefaultLayout>
        <ComputeLayout>
          <div className="mb-4 w-full bg-gray-50 rounded-lg border border-gray-200 ">
            <div className="p-3 bg-white rounded-t-lg">
              <textarea
                id="comment"
                rows="4"
                className="min-h-[400px] block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-cyan-500 focus:border-cyan-500 "
                placeholder="Parámetros..."
                defaultValue={params}
              ></textarea>
              <Transition
                show={params !== "" && calc}
                enter="transition ease-out duration-500"
                enterFrom="transform opacity-0 scale-95"
                enterTo="transform opacity-100 scale-100"
                leave="transition ease-in duration-500"
                leaveFrom="transform opacity-100 scale-100"
                leaveTo="transform opacity-0 scale-95"
              >
                <label
                  htmlFor="message"
                  class={`block m-2 text-sm font-medium text-gray-900 dark:text-gray-400`}
                >
                  Respuesta
                </label>

                <textarea
                  id="message"
                  rows="4"
                  className={`block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-cyan-500 focus:border-cyan-500`}
                  readOnly
                ></textarea>
              </Transition>
            </div>
            <div className="flex justify-between items-center py-2 px-3 border-t ">
              <input
                type="file"
                className="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-slate-100 file:text-black hover:file:bg-slate-200"
                name="parametros"
                key={1}
                onChange={(e) => {
                  setCalc(false);
                  setParams("");
                  if (e.target.files && e.target.files[0]) {
                    let reader = new FileReader();
                    //let fileName = e.target.files[0].name;
                    reader.onloadend = (e) => {
                      setParams("");
                      setParams(e.target.result);
                    };
                    reader.readAsText(e.target.files[0]);
                  }
                }}
              />

              <div className="flex pl-0 space-x-1 sm:pl-2">
                <button
                  className="inline-flex items-center py-2 px-4 border
                  border-transparent text-sm font-medium rounded-md text-white bg-cyan-600
                  hover:bg-cyan-500 focus:outline-none focus:ring-2 focus:ring-offset-2
                  focus:ring-cyan-500 duration-500 cursor-pointer disabled:hover:bg-slate-100 disabled:bg-slate-100 disabled:text-black"
                  disabled={loading}
                  onClick={async () => {
                    if (params !== "") {
                      try {
                        setLoading(true);
                        //fetch
                        const req = {
                          headers: {
                            "content-Type": "multipart/form-data",
                          },
                          data: params,
                          params: { model: 0 },
                          method: "GET",
                        };
                        const data = await fetch(`${api2.host}/solve`, req);
                        const res = await data.json();
                        console.log(res);
                        setParams(res);
                        setLoading(false);
                        setCalc(true);
                      } catch (error) {
                        setModalOpen(true);
                        setModalOptions({
                          title: errorCodes.COMPUTE_ERROR.title,
                          description: errorCodes.COMPUTE_ERROR.description,
                          error: true,
                        });
                        setLoading(false);
                        setCalc(false);
                      }
                    } else {
                      setModalOpen(true);
                      setModalOptions({
                        title: errorCodes.INCOMPLETE_PARAMS.title,
                        description: errorCodes.INCOMPLETE_PARAMS.description,
                        error: false,
                      });
                    }
                  }}
                >
                  {loading ? (
                    <Spinner loading />
                  ) : (
                    <FontAwesomeIcon
                      className={`text-white mr-2`}
                      icon={faPlay}
                    />
                  )}
                  Calcular
                </button>
              </div>
            </div>
          </div>

          <p className="ml-auto text-xs text-gray-500 ">
            Aquí se deben escribir los parámetros del problema que se desea
            resolver.
          </p>
        </ComputeLayout>
      </DefaultLayout>
    </ProtectedRoute>
  );
};

const mapState = (state) => {
  return {
    //Modal props
    modalOpen: state.modalOpen,
  };
};

const mapProps = {
  setModalOpen,
  setModalOptions,
};

export default connect(mapState, mapProps)(Compute);
