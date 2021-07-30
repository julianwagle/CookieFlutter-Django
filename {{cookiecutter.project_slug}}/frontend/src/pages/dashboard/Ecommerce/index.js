// @flow
import React, { useState } from 'react';
import { Row, Col } from 'react-bootstrap';

// components
import Datepicker from '../../../components/Datepicker';

import Statistics from './Statistics';
import PerformanceChart from './PerformanceChart';
import RevenueChart from './RevenueChart';
import RevenueByLocationChart from './RevenueByLocationChart';
import SalesChart from './SalesChart';
import Activity from './Activity';
import Products from './Products';

const EcommerceDashboard = (): React$Element<React$FragmentType> => {
    const [selectedDate, setSelectedDate] = useState(new Date());

    const onDateChange = (date) => {
        if (date) {
            setSelectedDate(date);
        }
    };

    return (
        <>
            <Row>
                <Col>
                    <div className="page-title-box">
                        <div className="page-title-right">
                            <form className="d-flex">
                                <div className="input-group">
                                    <Datepicker
                                        value={selectedDate}
                                        inputClass="form-control-light"
                                        onChange={(date) => {
                                            onDateChange(date);
                                        }}
                                    />
                                </div>
                                <button className="btn btn-primary ms-2">
                                    <i className="mdi mdi-autorenew"></i>
                                </button>
                                <button className="btn btn-primary ms-1">
                                    <i className="mdi mdi-filter-variant"></i>
                                </button>
                            </form>
                        </div>
                        <h4 className="page-title">Dashboard</h4>
                    </div>
                </Col>
            </Row>

            <Row>
                <Col xl={5}>
                    <Statistics />
                </Col>

                <Col xl={7}>
                    <PerformanceChart />
                </Col>
            </Row>

            <Row>
                <Col xl={8}>
                    <RevenueChart />
                </Col>
                <Col xl={4}>
                    <RevenueByLocationChart />
                </Col>
            </Row>

            <Row>
                <Col xl={% raw %}{{ span: 6, order: 1 }}{% endraw %} lg={% raw %}{{ order: 2 }}>{% endraw %}
                    <Products />
                </Col>
                <Col xl={3} lg={% raw %}{{ span: 6, order: 1 }}>{% endraw %}
                    <SalesChart />
                </Col>
                <Col xl={3} lg={% raw %}{{ span: 6, order: 1 }}>{% endraw %}
                    <Activity />
                </Col>
            </Row>
        </>
    );
};

export default EcommerceDashboard;