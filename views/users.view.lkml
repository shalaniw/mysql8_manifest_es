view: users {
  sql_table_name: looker_test.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: epoch_at {
    type: number
    sql: ${TABLE}.epoch_at ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: yyyymmdd_at {
    type: number
    sql: ${TABLE}.yyyymmdd_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, orders.count]
  }

  parameter: item_for_dynamic_sum {
    type: unquoted
    allowed_value: {
      label: "Total Id Num"
      value: "id"
    }
  }

  parameter: item_for_age {
    type: unquoted
    allowed_value: {
      label: "Age"
      value: "age"
    }
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    label_from_parameter: item_for_age
  }

  measure: dynamic_sum {
    type: sum
    sql: ${TABLE}.{% parameter item_for_dynamic_sum %} ;;
    label_from_parameter: item_for_dynamic_sum
  }
}
