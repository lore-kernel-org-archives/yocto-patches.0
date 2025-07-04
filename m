Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B3C8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 21:24:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.1083.1751649169202916035
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=JaPYMyCi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: nicolas.dechesne@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564Bp8Ic013520
	for <yocto-patches@lists.yoctoproject.org>; Fri, 4 Jul 2025 17:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+83D0UzwU4TPnl4QkTR8FAjZjyMIMSs0m53
	MCbDqXc0=; b=JaPYMyCilNXI8ajsHP0bk1n0LwAcoZMDs0JyJTaNxLN+6x5sj/2
	VzEj2FdOc3fs6rT3tDz/UcZfXC3rBWTXju8FYFyXMJ//Fl0Idvz7nsvWERpy2+PJ
	EcL8N3iivFNwe3bdIS6y7avSxpt2eWG+tOAwURykA3MNm19Ws5Koj2SB9WmRj2a4
	L0YYFWl/cic1Z4VDl7SLbES+GcrOLxhTGYnBVAExC3qKuPF5eBcPGtz41gjjURDM
	7aEKwrmznaKnzfi/fJTH7hFCjCljCP8cuTHZQvS1sq2tXC6va6/vjoFsm6EzrQ+d
	mSB+X+t4jnenWkFxGVGN/EtvBEV7rmA8VWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j802c9up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:12:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d40185a630so178167985a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649167; x=1752253967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+83D0UzwU4TPnl4QkTR8FAjZjyMIMSs0m53MCbDqXc0=;
        b=Ko3bN6inXj7/kJDJg1MEdOS7NU9uUNhr5QqpsINUzCendmX0s+9wIexhJejRr82iTB
         jNpMwVLMMGXRNmWzlIMwC6pt61JuFKep5n9DczYJ4kzA79Hw9qtQLJj665jP9VJuxF3F
         wA76JsiqwdO1K0e529AeMTo8lZAZ/Bh1aTe0CWLCuVQedxHEqH3uMq0Udk0fLzisCmQ0
         ba6z6YKEO3jB9PpJOs+i7ZrcmjWj3tPPTw9Fe39W2xRVsXCBXQVSzVDoEKUtkAF2tya7
         eRlQZC6hlBQscnxPrgmK/mtk4RKL6mN/7g9F9Gcu5AFsJSSLDvu9o7FVOm8tFykRqqr3
         LARg==
X-Gm-Message-State: AOJu0Yy0h0El1J84LM6BwayHTnjVQwXWuRsURfvMxgpCyKUzOdiLxNX0
	ogBUVyCBmuMULXduX3/I+IHMQqaA+RC5JPI0+l4d1MQFn5Fznw4esnpkca8HPbuTT8YWNrrmS7w
	7ycOeKTZRhRzynYaNJXX/qbIXKqMNxOBHlS/y8CaXFJWltF4tRKalfx1b286hm5VUr+/zJmj3eZ
	3ykfthat0Lgg==
X-Gm-Gg: ASbGncvPdjulnslZV1kpTALycnqgmdPbk/kyIKU9TOfYyI5k5u0czPE5Xs7hQvj9xTI
	pHlWxpIUyLsYaYXy3qHkduOKJIQQiu1mGr6UkPE36aGlelNpHWlAJKA5GzD8r3RiqoT71sBntPZ
	CtMW6ETlun859wNi6EPVN6tvPcVo24W0t3LuxRh7uks9E1N1eJ8TzN5PV4xWtAyO1hRWNNfIu7e
	w3p0YSc12FoXi8N3ZzK5xWKwmLTaqdzCbx9IsYgJtwfKJGlNJTre+rSggsmFCqUzn/qDsYXcCiU
	gqpBLZrlyzpmdCTKAQ9X2C8prMgjp//cfxu14UxAO6R7g3HVYhUt64RSTm4=
X-Received: by 2002:a05:620a:2b95:b0:7d5:c26a:f24c with SMTP id af79cd13be357-7d5df0f9919mr380035685a.21.1751649166704;
        Fri, 04 Jul 2025 10:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdz/ScciouFE0Sx+5FKaa0B/SLvLblYUmeeobjI9dwAenWT9dWdj/8R5Qp9sb26ZtDtM9bdg==
X-Received: by 2002:a05:620a:2b95:b0:7d5:c26a:f24c with SMTP id af79cd13be357-7d5df0f9919mr380031785a.21.1751649166205;
        Fri, 04 Jul 2025 10:12:46 -0700 (PDT)
Received: from hu-ndechesn-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692a9fcsm200765166b.49.2025.07.04.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:12:45 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Nicolas Dechesne <nicolas.dechesne@oss.qualcomm.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: add initial CI for meta-qcom
Date: Fri,  4 Jul 2025 19:12:43 +0200
Message-Id: <20250704171243.2201495-1-nicolas.dechesne@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: YThfobfEebv2TO655HKzY_mK7bSU-hQE
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68680b90 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8
 a=1vkyLKxHXoks7R1aka0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: YThfobfEebv2TO655HKzY_mK7bSU-hQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEzMCBTYWx0ZWRfX/8DLYJ8APjkH
 hLssnL3UAMzPwf6L0KDs6oTDuRHddnSWA17DMWJaJ2YesOn1YE5gDKG2QWlUsga3DEoulO1PjXx
 ntnkZDe/r4BmCQhlradqlYOQ4gZB83HlAfGBlWnaKSBCKk+N+Op8697BKWmfp6m+i3hSOlsYcwD
 gzuZuJtRoJJdBavG3DMOzxOdsjP2fhWJeCnJH0qiDu5m4d+fhkjurUzhPbs16Vsys9oSgs2NUsn
 dQFBhqvKx+CbQyJSQYalZvHpsIQ7ancUuAWj6R61E8xP53lb68aZpKYBKMlm5XFqCiA+XJWbhJA
 6JSWVeYDNj5agAbU7E14QsBx6hrWCW92qJ4CYg8NkXN9iKBdNHcpJN9wRUQDmJksCU+xEqpxlV9
 S+UMJ9uLP1oGQQui3492QEKCnJCCaT6yPaWcOQQHU+eQEq1fhtBT8Z2MQ6wi2Gzblaa1b3oe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1031 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040130
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 21:24:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1766

* add meta-qcom in repo-defaults, since it's used for the first time
* add meta-qcom in check-layer-nightly

Running yocto-check-layer right now, shows:

INFO: Getting initial bitbake variables ...
INFO: Getting initial signatures ...
INFO: Adding layer meta-qcom
INFO: Starting to analyze: meta-qcom
INFO: ----------------------------------------------------------------------
INFO: test_bsp_defines_machines (bsp.BSPCheckLayer)
INFO:  ... ok
INFO: test_bsp_no_set_machine (bsp.BSPCheckLayer)
INFO:  ... ok
INFO: test_machine_signatures (bsp.BSPCheckLayer)
INFO:  ... skipped 'No machines set with --machines.'
INFO: No machines set with --machines.
INFO: test_machine_world (bsp.BSPCheckLayer)
INFO:  ... skipped 'No machines set with --machines.'
INFO: No machines set with --machines.
INFO: test_layerseries_compat (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_parse (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_patches_upstream_status (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_readme (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_security (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_show_environment (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_signatures (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_world (common.CommonCheckLayer)
INFO:  ... ok
INFO: test_world_inherit_class (common.CommonCheckLayer)
INFO:  ... ok
INFO: skipped "DistroCheckLayer: Layer meta-qcom isn't Distro one."
INFO: ----------------------------------------------------------------------
INFO: Ran 13 tests in 167.729s
INFO: OK
INFO:  (skipped=3)
INFO:
INFO: Summary of results:
INFO:
INFO: meta-qcom ... PASS

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@oss.qualcomm.com>
---
 config.json | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 3e01da3..f62d294 100644
--- a/config.json
+++ b/config.json
@@ -1219,7 +1219,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
+            "NEEDREPOS" : ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1259,6 +1259,10 @@
                     "HOSTTOOLS:remove = 'clang llvm-strip'"
                 ],
                 "EXTRACMDS" : ["export PATH=$PATH:${SCRIPTSDIR}/exein-path-intercepts; yocto-check-layer-wrapper ../meta-exein --dependency ../meta-openembedded/meta-oe --no-auto-dependency"]
+            },
+            "step10" : {
+                "shortname" : "Test meta-qcom YP Compatibility",
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --no-auto-dependency"]
             }
         },
         "metrics" : {
@@ -1921,6 +1925,12 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
+        "meta-qcom" : {
+            "url" : "https://github.com/qualcomm-linux/meta-qcom",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
+        },
         "auto-upgrade-helper" : {
             "url" : "git://git.yoctoproject.org/auto-upgrade-helper",
             "branch" : "master",
-- 
2.34.1


