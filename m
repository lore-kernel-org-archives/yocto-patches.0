Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D09CEDD81
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 13:09:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12094.1763471349659146008
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Nov 2025 05:09:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=f7XRlGxg;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=gRNCaL9h;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VgpJ2250590
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=k30sP3pIxzoCoMj5KtTT6pJbQt+FPzmYFVD
	ofdmAw4Y=; b=f7XRlGxgCQWJcQffLEZr/gG4Q6xKPHhSH+u8z94I5Ix6X3nTb5g
	Q/yHL02jPRKDsm+Mt4sWDtwwuTnPl0f+bw2h7bqHm96VCqbtj9+201Qr4zjuwOKf
	6LM+cUM2WHpMuZLzwYvBMbxxPtQxvbUGI4KW0ZJGzJuT5FgprXl1I0PX2DRgsygk
	/DgcmGGaVR5t7pnF6VIyZgexcl+js0ZhAYPY7T6SvSpLnft1MuDfAwGYq+HSwlkh
	OZfJuP0grEnyher6d67GBWP+1DmGqGUZP6BqYO0cZIyoCbvCHyoHKdUOdLpSWvku
	gw1hyHM0klFsDW24NRfomzzyYXVmvhgXv9w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5gs7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so13932004a91.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 05:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763471348; x=1764076148; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k30sP3pIxzoCoMj5KtTT6pJbQt+FPzmYFVDofdmAw4Y=;
        b=gRNCaL9hGFBimobUugPBkN9wivPF7hzgI53RTK2LJLDBWus6K4YkyrISsfYubJuFu3
         gss+ovU2HVIHB+DaZYhqo6aaqSor6bE2rmuLKkAuTYkq/3Yia37pnBpYr/4uaLlT9Jjn
         aZrtumH3Vs1EULOf75di385iK19bC89w0PnenyWTuVbzWJBk8QQD5QfEQLRw/IUnS6Yr
         BhOBuIK+87dhzckmU9KE918k9d0NwJzQ0CJ99xeVK/Uf1pKjgNEr/l+Tf+zXUWH6PT3a
         6Y2q67pQuL+uHL7CxwTB9pfWZgC8FQ0r2+xCaXltT5zyECAM5Ch884tvIDM8phNsQswB
         l5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763471348; x=1764076148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k30sP3pIxzoCoMj5KtTT6pJbQt+FPzmYFVDofdmAw4Y=;
        b=PeZ8P805Ty0zWSGA7qCooQh8slvfam+voIFVdoyyc2Xp3KwkuoCYmYmodzkroyapBO
         qcMpWIqAaKuexaH8Yjl4aHi+n+hjr/0fLe52Ya9OczrbEusAY1vdDzqKrM38vIAjc44G
         HYfE6VA+jXBjcdUy1P/DCWaI/GFrzN2WBS/1lS1KSJGavlxp1mV2hP/VSgOiQU9oXsmQ
         uMLhCS3NNj7EHCUkaOn6d3ocd8dHqwO3Q2v5W/xz1LPkVTsoZhiwmhCL0jRoTQWW83Yd
         WMuC5Mf7QvDSiy1N4/k6rQsKVOec336/9UPHnlol7ufWpNG9BWmx6rJfVqM8yF3McVfx
         xiHg==
X-Gm-Message-State: AOJu0YyBpLgvjTymqSgFhFif4TJXfPdlA2WqP4/ORcroATtPzhJR6dpd
	pwcwnQv9SED2EsXjA5fqEKRNBaa1x9q1AHM6VWw17TUV5X5Tgteuwmns5/8z5iOmqmGmVi+1S+6
	1lOQX8R76nwaZRuEM1iMqwVJKQZniUGNhikmWrAwKl9S7mwUBEkHSBbxKWK0h6gCmEh5CVfFAJu
	DY+1o7ZE3Xs3g3
X-Gm-Gg: ASbGncs7W2gFFHyZCXA7vwdh/49+ZkK6ckcM+e5/GZn78dCuUJlEDmZh23ElZV3oxB6
	iULQZkWq+sDk8xLLuFApkR8is/MAePzHncSx2bj4o5+0JeaNHjDZlIemW9AuA7X5b+gyA6kr803
	lS9RJ1VEkTj4P2V0Il58j6gqOgHdbnE8PMFoCpzW+0Mwy0VK3NehSpk8TgFfXOx8YbrTJUtsey+
	L9i/C1xL+qUQbXq0XqfWsrX+58OR7Xpf0hJZfx7UAA/PM7kw3OCzZwPVmEJewI+ht8IqOMWmi2O
	s0IKgZmaEJbi3OMcQrU5i6iV2TICglwbfJDhw936xpzfhXXtjiQVi6KjOSdOhdQINZEM63wE7h/
	RG8fZPQ3irFE3y7bGKQhA0JFfFxwoveLCHM/9r7Zu
X-Received: by 2002:a17:90b:3fc8:b0:340:b1b1:3d28 with SMTP id 98e67ed59e1d1-343fa75a9cdmr17912305a91.25.1763471348484;
        Tue, 18 Nov 2025 05:09:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUpHEQIZA2B2JH6WidZVHUzH5UAOrdozWqLgQFbbVXjZWQVIV4Wde5Nl6PJhKzih+8yJXEmQ==
X-Received: by 2002:a17:90b:3fc8:b0:340:b1b1:3d28 with SMTP id 98e67ed59e1d1-343fa75a9cdmr17912248a91.25.1763471347821;
        Tue, 18 Nov 2025 05:09:07 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d24b9sm16516514b3a.17.2025.11.18.05.09.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 05:09:07 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 1/2] selinux-python: make semanage RDEPENDS on sepolgen
Date: Tue, 18 Nov 2025 18:38:58 +0530
Message-ID: <20251118130859.946532-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F246i-dgOfZFBe6WPb1asuHHSKutaLxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEwNSBTYWx0ZWRfXzPPv2xgZLXnP
 mNIngN/jnBhlpZquzfZ6zhfzqAvItYlRenCvMYotetvcBRxcNy9k5GnhG7QT6XX7Lfrv8O6/6BR
 p9RQVUSREsXKMmlTv3Wx9tbBfrES+LJATFBwtH/m7n79z+9V3IwU9LBJxe3iMcCa5VqEID/s7fg
 okhhAKBUPG/aTgzZW5g19SKMGcQtb0KJWV+FczaWr898AenB8JhD00h2IdXQk96JjV8Uo3dLyi+
 7eRkZO/Nu5zcU2Jn4m6BTiMP61Owg+CFx54vqUoUJTpeBmW19XOk5kcCEoLzOERHBvIj3v0yONY
 oemv/kq5sXrcXY+QR2h6WEyCAIugsuk7iO3+95EyyX3nGenuD3ZWQKG21ZkliQLOUp2vwUUUQQh
 G/VullRrbo8uGNXGt7v/hJckgj0NLg==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c6ff5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B4qtFHoHhPDmKG_lr2MA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: F246i-dgOfZFBe6WPb1asuHHSKutaLxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180105
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2580

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Make the dependency explicit, otherwise when it leads to errors when it
is not included.

| ~ # semanage permissive
| Traceback (most recent call last):
|   File "/sbin/semanage", line 29, in <module>
|     import seobject
|   File "/usr/lib/python3.13/site-packages/seobject.py", line 33, in <module>
|     import sepolicy
|   File "/usr/lib/python3.13/site-packages/sepolicy/__init__.py", line 8, in <module>
|     import sepolgen.defaults as defaults
| ModuleNotFoundError: No module named 'sepolgen'

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-security/selinux/selinux-python_3.9.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.9.bb
index 88850ad..62226cf 100644
--- a/recipes-security/selinux/selinux-python_3.9.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -53,6 +53,7 @@ RDEPENDS:${PN}-semanage = "\
         libselinux-python \
         audit-python \
         ${PN} \
+        ${PN}-sepolgen \
 "
 PACKAGECONFIG ??= "sepolicy-generate"
 PACKAGECONFIG[sepolicy-generate] = ",,,"
-- 
2.51.2


