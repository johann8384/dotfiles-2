curl -XDELETE http://el.sjc2.turn.com:9200/_template/ossec_per_index;
curl -XPUT http://el.sjc2.turn.com:9200/_template/ossec_per_index -d '
{
  "template":"ossec-*",
  "settings":{
    "index.analysis.analyzer.default.stopwords":"_none_",
    "index.refresh_interval":"5s",
    "index.analysis.analyzer.default.type":"standard"
  },
  "mappings":{
    "_default_":{
      "properties":{
        "@fields.hostname":{
          "type":"string",
          "index":"not_analyzed"
        },
        "@fields.product":{
          "type":"string",
          "index":"not_analyzed"
        },
        "@message":{
          "type":"string",
          "index":"not_analyzed"
        },
        "@timestamp":{
          "type":"date"
        },
        "@version":{
          "type":"string",
          "index":"not_analyzed"
        },
        "ossec.acct":{
          "type":"string",
          "index":"not_analyzed"
        },
        "ossec.classification":{
          "type":"string",
          "index":"not_analyzed"
        },
        "ossec.description":{
          "type":"string",
          "index":"not_analyzed"
        },
        "ossec.component":{
          "type":"string",
          "index":"not_analyzed"
        },
        "ossec.server":{
          "type":"string",
          "index":"not_analyzed"
        },
        "raw_message":{
          "type":"string",
          "index":"analyzed"
        },
        "reporting_ip":{
          "type":"string",
          "index":"not_analyzed"
        },
        "reporting_source":{
          "type":"string",
          "index":"analyzed"
        },
        "ossec.id":{
          "type":"integer"
        },
        "severity":{
          "type":"integer"
        },
        "signature":{
          "type":"string",
          "index":"not_analyzed"
        },
        "src_ip":{
          "type":"string",
          "index":"not_analyzed"
        },
        "geoip":{
          "type" : "object",
          "dynamic": true,
          "path": "full",
          "properties" : {
            "location" : { "type" : "geo_point" }
          }
        }
      },
      "_all":{
        "enabled":true
      }
    }
  }
}';
curl -XDELETE http://el.sjc2.turn.com:9200/_template/logstash_per_index;
curl -XPUT http://el.sjc2.turn.com:9200/_template/logstash_per_index -d '{
  "template" : "logstash-*",
  "settings" : {
    "index.refresh_interval" : "5s",
    "analysis" : {
      "analyzer" : {
        "default" : {
          "type" : "standard",
          "stopwords" : "_none_"
        }
      }
    }
  },
  "mappings" : {
    "_default_" : {
      "_all" : {"enabled" : true},
      "dynamic_templates" : [ {
        "ip_addresses" : {
          "match": "*_ip", 
          "match_mapping_type": "string",
          "mapping": {
            "type": "multi_field",
            "fields" : {
              "src_ip" : { "type" : "ip" },
              "dst_ip" : { "type" : "ip" }
            }
          }   
        },
        "string_fields" : {
          "match" : "*",
          "match_mapping_type" : "string",
          "mapping" : {
            "type" : "multi_field",
            "fields" : {
              "name" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "host" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "program" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "message" : {"type": "string", "index" : "analyzed", "omit_norms" : true, "analyzer": "english" },
              "changes" : {"type": "string", "index" : "analyzed", "omit_norms" : true, "analyzer": "english" },
              "class" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "command" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "nagios_hostname" : {"type": "string", "index" : "analyzed", "omit_norms" : true },
              "severity_label": { "type": "string", "index": "analyzed", "omit_norms" : true },
              "facility_label": { "type": "string", "index": "analyzed", "omit_norms" : true },
              "syslog_severity": { "type": "string", "index": "analyzed", "omit_norms" : true },
              "syslog_facility": { "type": "string", "index": "analyzed", "omit_norms" : true },
              "log_source": { "type": "string", "index": "analyzed", "omit_norms" : true }
            }
          }
        }
      } ],
      "properties" : {
        "@version": { "type": "string", "index": "not_analyzed" },
        "geoip"  : {
          "type" : "object",
          "dynamic": true,
          "path": "full",
          "properties" : {
            "ip" : { type: "ip" },
            "location" : { "type" : "geo_point" }
          }
        },
        "tags": { "type": "string", "index": "not_analyzed" },
        "pid": { "type": "long", "index": "not_analyzed" },
        "priority": { "type": "integer", "index": "not_analyzed" },
        "severity": { "type": "integer", "index": "not_analyzed" },
        "facility": { "type": "integer", "index": "not_analyzed" },
        "syslog_severity_code": { "type": "integer", "index": "not_analyzed" },
        "syslog_facility_code": { "type": "integer", "index": "not_analyzed" }
      }
    }
  }
}';
curl -XDELETE http://el.sjc2.turn.com:9200/_template/packetbeat_per_index;
curl -XPUT http://el.sjc2.turn.com:9200/_template/packetbeat_per_index -d '
{
  "template": "packetbeat-*",
  "settings": {
    "index.refresh_interval": "5s",
    "analysis": {
      "analyzer": {
        "default": {
          "type": "standard",
          "stopwords": "_none_"
        }
      }
    }
  },
  "mappings": {
    "_default_": {
      "_all": {
        "enabled": true
      },
      "dynamic_templates": [
        {
          "raw_fields": {
            "match": "*.raw",
            "match_mapping_type": "string",
            "mapping": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        },
        {
          "server_fields": {
            "match": "*_server",
            "match_mapping_type": "string",
            "mapping": {
              "type": "string",
              "index": "not_analyzed"
            }
          }
        }
      ]
    }
  }
}';
curl -XDELETE http://el.sjc2.turn.com:9200/_template/netflow_per_index;
curl -XPUT http://el.sjc2.turn.com:9200/_template/netflow_per_index -d '
{
  "template" : "netflow-*",
  "settings": {
    "index.cache.field.type": "soft",
    "index.store.compress.stored": true
  },
  "mappings" : {
    "_default_" : {
      "_all" : {
        "enabled" : false
      },
      "properties" : {
        "@message":     { "index": "analyzed", "type": "string"  },
        "@source":      { "index": "not_analyzed", "type": "string"  },
        "@source_host": { "index": "not_analyzed", "type": "string" },
        "@host": { "index": "not_analyzed", "type": "string" },
        "@source_path": { "index": "not_analyzed", "type": "string" },
        "@tags":        { "index": "not_analyzed", "type": "string" },
        "@timestamp":   { "index": "not_analyzed", "type": "date" },
        "@type":        { "index": "not_analyzed", "type": "string" },
        "netflow": {
          "dynamic": true,
          "path": "full",
          "properties": {
            "version": { "index": "analyzed", "type": "integer" },
            "first_switched": { "index": "not_analyzed", "type": "date" },
            "last_switched": { "index": "not_analyzed", "type": "date" },
            "direction": { "index": "not_analyzed", "type": "integer" },
            "flowset_id": { "index": "not_analyzed", "type": "integer" },
            "flow_sampler_id": { "index": "not_analyzed", "type": "integer" },
            "flow_seq_num": { "index": "not_analyzed", "type": "long" },
            "src_tos": { "index": "not_analyzed", "type": "integer" },
            "tcp_flags": { "index": "not_analyzed", "type": "integer" },
            "protocol": { "index": "not_analyzed", "type": "integer" },
            "ipv4_next_hop": { "index": "analyzed", "type": "ip" },
            "in_bytes": { "index": "not_analyzed", "type": "long" },
            "in_pkts": { "index": "not_analyzed", "type": "long" },
            "out_bytes": { "index": "not_analyzed", "type": "long" },
            "out_pkts": { "index": "not_analyzed", "type": "long" },
            "input_snmp": { "index": "not_analyzed", "type": "long" },
            "output_snmp": { "index": "not_analyzed", "type": "long" },
            "ipv4_dst_addr": { "index": "analyzed", "type": "ip" },
            "ipv4_src_addr": { "index": "analyzed", "type": "ip" },
            "dst_mask": { "index": "analyzed", "type": "integer" },
            "src_mask": { "index": "analyzed", "type": "integer" },
            "dst_as": { "index": "analyzed", "type": "integer" },
            "src_as": { "index": "analyzed", "type": "integer" },
            "l4_dst_port": { "index": "not_analyzed", "type": "long" },
            "l4_src_port": { "index": "not_analyzed", "type": "long" }
          },
          "type": "object"
        }
      }
    }
  }
}'
