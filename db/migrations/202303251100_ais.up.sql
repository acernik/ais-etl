BEGIN;


    CREATE TABLE position_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        navigational_status BIGSERIAL NOT NULL,
        rate_of_turn BIGSERIAL NOT NULL,
        sog DOUBLE PRECISION NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        cog DOUBLE PRECISION NOT NULL,
        true_heading BIGSERIAL NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        special_manoeuvre_indicator BIGSERIAL NOT NULL,
        spare BIGSERIAL NOT NULL,
        raim BOOLEAN NOT NULL,
        communication_state BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE addressed_safety_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        sequenceinteger BIGSERIAL NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        retransmission BOOLEAN NOT NULL,
        spare BOOLEAN NOT NULL,
        text TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE application_id (
        id BIGSERIAL PRIMARY KEY,

        valid BOOLEAN NOT NULL,
        designated_area_code BIGSERIAL NOT NULL,
        function_identifier BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE addressed_binary_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        sequenceinteger BIGSERIAL NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        retransmission BOOLEAN NOT NULL,
        spare BOOLEAN NOT NULL,
        abm_application_id BIGSERIAL NOT NULL,
        binary_data TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_address_binary_message_application_id FOREIGN KEY (abm_application_id) REFERENCES application_id (id)
    );


    CREATE TABLE ship_static_data_dimensions (
        id BIGSERIAL PRIMARY KEY,

        A BIGSERIAL NOT NULL,
        B BIGSERIAL NOT NULL,
        C BIGSERIAL NOT NULL,
        D BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE aids_to_navigation_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        type BIGSERIAL NOT NULL,
        name TEXT NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        dimension BIGSERIAL NOT NULL,
        fixtype BIGSERIAL NOT NULL,
        timestamp BIGSERIAL NOT NULL,
        off_position BOOLEAN NOT NULL,
        aton BIGSERIAL NOT NULL,
        raim BOOLEAN NOT NULL,
        virtual_aton BOOLEAN NOT NULL,
        assigned_mode BOOLEAN NOT NULL,
        spare BOOLEAN NOT NULL,
        name_extension TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_aids_to_navigation_report_dimension FOREIGN KEY (dimension) REFERENCES ship_static_data_dimensions (id)
    );


    CREATE TABLE assigned_mode_command (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        mode BIGSERIAL NOT NULL,
        interval BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );

    CREATE TABLE assigned_mode_command_commands (
        id BIGSERIAL PRIMARY KEY,

        assigned_mode_command_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        amcc_offset BIGSERIAL NOT NULL,
        increment BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_assigned_mode_command_commands_assigned_mode_command_id FOREIGN KEY (assigned_mode_command_id) REFERENCES assigned_mode_command (id)
    );


    CREATE TABLE base_station_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        utc_year BIGSERIAL NOT NULL,
        utc_month BIGSERIAL NOT NULL,
        utc_day BIGSERIAL NOT NULL,
        utc_hour BIGSERIAL NOT NULL,
        utc_minute BIGSERIAL NOT NULL,
        utc_second BIGSERIAL NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        fixtype BIGSERIAL NOT NULL,
        long_range_enable BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        raim BOOLEAN NOT NULL,
        communication_state BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE binary_acknowledge (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE binary_acknowledge_destinations0 (
        id BIGSERIAL PRIMARY KEY,

        binary_acknowledge_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        sequenceinteger BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_binary_acknowledge_destinations0_binary_acknowledge_id FOREIGN KEY (binary_acknowledge_id) REFERENCES binary_acknowledge (id)
    );


    CREATE TABLE addressed_binary_message_application_id (
        id BIGSERIAL PRIMARY KEY,

        valid BOOLEAN NOT NULL,
        designated_area_code BIGSERIAL NOT NULL,
        function_identifier BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE binary_broadcast_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        application_id BIGSERIAL NOT NULL,
        binary_data TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_binary_broadcast_message_application_id FOREIGN KEY (application_id) REFERENCES addressed_binary_message_application_id (id)
    );


    CREATE TABLE channel_management_area (
        id BIGSERIAL PRIMARY KEY,

        longitude1 DOUBLE PRECISION NOT NULL,
        latitude1 DOUBLE PRECISION NOT NULL,
        longitude2 DOUBLE PRECISION NOT NULL,
        latitude2 DOUBLE PRECISION NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE channel_management_unicast (
        id BIGSERIAL PRIMARY KEY,

        address_station1 BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        address_station2 BIGSERIAL NOT NULL,
        spare3 BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE channel_management (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        channel_a BIGSERIAL NOT NULL,
        channel_b BIGSERIAL NOT NULL,
        txrx_mode BIGSERIAL NOT NULL,
        power BIGSERIAL NOT NULL,
        address BIGSERIAL NOT NULL,
        band_a BIGSERIAL NOT NULL,
        band_b BIGSERIAL NOT NULL,
        zone_size BIGSERIAL NOT NULL,
        net_management BIGSERIAL NOT NULL,
        area BIGSERIAL NOT NULL,
        unicast BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_channel_management_area FOREIGN KEY (area) REFERENCES channel_management_area (id),
        CONSTRAINT fk_channel_management_unicast FOREIGN KEY (unicast) REFERENCES channel_management_unicast (id)
    );


    CREATE TABLE coordinated_utc_inquiry (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE data_link_management_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE data_link_management_message_data0 (
        id BIGSERIAL PRIMARY KEY,

        data_link_management_message_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        dlmmd_offset BIGSERIAL NOT NULL,
        integer_of_slots BIGSERIAL NOT NULL,
        time_out BIGSERIAL NOT NULL,
        increment BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_data_link_management_message_data0_data_link_management_message_id FOREIGN KEY (data_link_management_message_id) REFERENCES data_link_management_message (id)
    );


    CREATE TABLE extended_class_b_position_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        sog DOUBLE PRECISION NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        cog DOUBLE PRECISION NOT NULL,
        true_heading BIGSERIAL NOT NULL,
        timestamp BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        name TEXT NOT NULL,
        type BIGSERIAL NOT NULL,
        dimension BIGSERIAL NOT NULL,
        fix_type BIGSERIAL NOT NULL,
        raim BOOLEAN NOT NULL,
        dte BOOLEAN NOT NULL,
        assigned_mode BOOLEAN NOT NULL,
        spare3 BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_extended_class_b_position_report_dimension FOREIGN KEY (dimension) REFERENCES ship_static_data_dimensions (id)
    );


    CREATE TABLE gnss_broadcast_binary_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        data TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE group_assignment_command (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare1 BIGSERIAL NOT NULL,
        longitude1 DOUBLE PRECISION NOT NULL,
        latitude1 DOUBLE PRECISION NOT NULL,
        longitude2 DOUBLE PRECISION NOT NULL,
        latitude2 DOUBLE PRECISION NOT NULL,
        station_type BIGSERIAL NOT NULL,
        ship_type BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        txrx_mode BIGSERIAL NOT NULL,
        reporting_interval BIGSERIAL NOT NULL,
        quiet_time BIGSERIAL NOT NULL,
        spare3 BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE interrogation (
       id BIGSERIAL PRIMARY KEY,

       message_id BIGSERIAL NOT NULL,
       repeat_indicator BIGSERIAL NOT NULL,
       user_id BIGSERIAL NOT NULL,
       valid BOOLEAN NOT NULL,
       spare BIGSERIAL NOT NULL,

       created_at TIMESTAMP NOT NULL,
       updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE interrogation_station1_msg1 (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        interrogation_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        station_id BIGSERIAL NOT NULL,
        slot_offset BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_interrogation_station1_msg1_interrogation_id FOREIGN KEY (interrogation_id) REFERENCES interrogation (id)
    );


    CREATE TABLE interrogation_station1_msg2 (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        interrogation_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        slot_offset BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_interrogation_station1_msg2_interrogation_id FOREIGN KEY (interrogation_id) REFERENCES interrogation (id)
    );


    CREATE TABLE interrogation_station2 (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        interrogation_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare1 BIGSERIAL NOT NULL,
        station_id BIGSERIAL NOT NULL,
        slot_offset BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_interrogation_station2_interrogation_id FOREIGN KEY (interrogation_id) REFERENCES interrogation (id)
    );


    CREATE TABLE long_range_ais_broadcast_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        raim BOOLEAN NOT NULL,
        navigational_status BIGSERIAL NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        sog DOUBLE PRECISION NOT NULL,
        cog DOUBLE PRECISION NOT NULL,
        position_latency BOOLEAN NOT NULL,
        spare BOOLEAN NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE multi_slot_binary_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        destination_id_valid BOOLEAN NOT NULL,
        application_id_valid BOOLEAN NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        spare1 BIGSERIAL NOT NULL,
        application_id BIGSERIAL NOT NULL,
        payload TEXT NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        communication_state_is_itdma BOOLEAN NOT NULL,
        communication_state BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_multi_slot_binary_message_application_id FOREIGN KEY (application_id) REFERENCES addressed_binary_message_application_id (id)
    );


    CREATE TABLE safety_broadcast_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare BIGSERIAL NOT NULL,
        text TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE ship_static_data_eta (
        id BIGSERIAL PRIMARY KEY,

        month BIGSERIAL NOT NULL,
        day BIGSERIAL NOT NULL,
        hour BIGSERIAL NOT NULL,
        minute BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );

    CREATE TABLE ship_static_data (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        ais_version BIGSERIAL NOT NULL,
        imo_number BIGSERIAL NOT NULL,
        call_sign TEXT NOT NULL,
        name TEXT NOT NULL,
        type BIGSERIAL NOT NULL,
        dimension BIGSERIAL NOT NULL,
        fix_type BIGSERIAL NOT NULL,
        eta BIGSERIAL NOT NULL,
        maximum_static_draught DOUBLE PRECISION NOT NULL,
        destination TEXT NOT NULL,
        dte BOOLEAN NOT NULL,
        spare BOOLEAN NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_ship_static_data_dimension FOREIGN KEY (dimension) REFERENCES ship_static_data_dimensions (id),
        CONSTRAINT fk_ship_static_data_eta FOREIGN KEY (eta) REFERENCES ship_static_data_eta (id)
    );


    CREATE TABLE single_slot_binary_message (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        destination_id_valid BOOLEAN NOT NULL,
        application_id_valid BOOLEAN NOT NULL,
        destination_id BIGSERIAL NOT NULL,
        spare BIGSERIAL NOT NULL,
        application_id BIGSERIAL NOT NULL,
        payload TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_single_slot_binary_message_application_id FOREIGN KEY (application_id) REFERENCES addressed_binary_message_application_id (id)
    );


    CREATE TABLE standard_class_b_position_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        spare1 BIGSERIAL NOT NULL,
        sog DOUBLE PRECISION NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        cog DOUBLE PRECISION NOT NULL,
        true_heading BIGSERIAL NOT NULL,
        timestamp BIGSERIAL NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        class_b_unit BOOLEAN NOT NULL,
        class_b_display BOOLEAN NOT NULL,
        class_b_dsc BOOLEAN NOT NULL,
        class_b_band BOOLEAN NOT NULL,
        class_b_msg22 BOOLEAN NOT NULL,
        assigned_mode BOOLEAN NOT NULL,
        raim BOOLEAN NOT NULL,
        communication_state_is_itdma BOOLEAN NOT NULL,
        communication_state BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE standard_search_and_rescue_aircraft_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        altitude BIGSERIAL NOT NULL,
        sog DOUBLE PRECISION NOT NULL,
        position_accuracy BOOLEAN NOT NULL,
        longitude DOUBLE PRECISION NOT NULL,
        latitude DOUBLE PRECISION NOT NULL,
        cog DOUBLE PRECISION NOT NULL,
        timestamp BIGSERIAL NOT NULL,
        alt_from_baro BOOLEAN NOT NULL,
        spare1 BIGSERIAL NOT NULL,
        dte BOOLEAN NOT NULL,
        spare2 BIGSERIAL NOT NULL,
        assigned_mode BOOLEAN NOT NULL,
        raim BOOLEAN NOT NULL,
        communication_state_is_itdma BOOLEAN NOT NULL,
        communication_state BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE static_data_report_report_a (
        id BIGSERIAL PRIMARY KEY,

        valid BOOLEAN NOT NULL,
        name TEXT NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL
    );


    CREATE TABLE static_data_report_report_b (
        id BIGSERIAL PRIMARY KEY,

        valid BOOLEAN NOT NULL,
        ship_type BIGSERIAL NOT NULL,
        vendor_id_name TEXT NOT NULL,
        vendor_id_model BIGSERIAL NOT NULL,
        vendor_id_serial BIGSERIAL NOT NULL,
        call_sign TEXT NOT NULL,
        dimension BIGSERIAL NOT NULL,
        fix_type BIGSERIAL NOT NULL,
        spare BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_static_data_report_report_b_dimension FOREIGN KEY (dimension) REFERENCES ship_static_data_dimensions (id)
    );


    CREATE TABLE static_data_report (
        id BIGSERIAL PRIMARY KEY,

        message_id BIGSERIAL NOT NULL,
        repeat_indicator BIGSERIAL NOT NULL,
        user_id BIGSERIAL NOT NULL,
        valid BOOLEAN NOT NULL,
        reserved BIGSERIAL NOT NULL,
        part_number BOOLEAN NOT NULL,
        report_a BIGSERIAL NOT NULL,
        report_b BIGSERIAL NOT NULL,

        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,

        CONSTRAINT fk_static_data_report_report_a FOREIGN KEY (report_a) REFERENCES static_data_report_report_a (id),
        CONSTRAINT fk_static_data_report_report_b FOREIGN KEY (report_b) REFERENCES static_data_report_report_b (id)
    );


COMMIT;