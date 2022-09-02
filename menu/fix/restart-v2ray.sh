#!/bin/bash

systemctl daemon-reload
systemctl enable v2ray
systemctl restart v2ray
systemctl restart nginx
systemctl enable runn
systemctl restart runn
