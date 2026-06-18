Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016D2CD98F6
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 16:00:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22843.1781798410326350479
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 09:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=KvwDcqF5;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=BtShs9Ht;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFFl172116227
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pyp/E7z237m
	72ywD1GlLJVI1glQpfYAzU5bVc0kV0gY=; b=KvwDcqF5fNOuXy29STmoxGTfQk1
	86K9BvXOfV6RFPW45YXEFNcmjvVdpqIV15dbYdOfRxUNx1Vjj3pqlbeFdsEnDYSt
	T0BUJaXH8mpqYhfO1A80U/Z0hluCbfd7Sw29+Mw6PCLY1gLIos/0C9hv24/cwLlm
	Labcjx06i7vW9wk0VrJOPs0kFiAZtnDmzUzPoDoh31VW+EIKudq8rw9s0qBrySsQ
	tVkBY73gav+vDnkg6V3cP96fYAE/a3tCM9qG1BB9u3Ei1AXOfGDpgoS1NgE72jtg
	w4k+V9MYjd63Idb9/jaPosa7ls7HOqoOWI27r0ZHI585l6Vw5A8fY6BTMww==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12km8bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963b0a0b727so269556241.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781798408; x=1782403208; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyp/E7z237m72ywD1GlLJVI1glQpfYAzU5bVc0kV0gY=;
        b=BtShs9HtmqubGGXWyQgu1A3qVICAgNnY15kleqkjyQvUDDTJAEzEk9GM9MZoPJfEHb
         WF+UAdHcuB+sNmUx+vdw48mbUPl/B99msqAYxJPxNCCnoyWOybxI8mgTA4Kfyc7HJQw2
         A6LHmkKt4Yr78nuV7zRmrJ9jTjGuWcmXMJtDzvW8mEmPBdgjhRcTCEdqmdNewlXwa5Q4
         khKWhD1XPzLRY8mg3vJbWLevYHuAwp5LNYBtNL4gmP78DqykM3noutRK/na9KXjUvL8w
         xQpsh+XEBBGIrkI7UB7F53/r2YUE5DUlKcpl4Z0OwNRBs3EujCrJmDX8WLtljzmSffLZ
         UF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798408; x=1782403208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pyp/E7z237m72ywD1GlLJVI1glQpfYAzU5bVc0kV0gY=;
        b=lKB/9G6dhomAtSJnf5N1WJ/1ViaMUMxTCsNSlohcnc31CUlB7rH7biDW9ME0M9KkkD
         RoyZ5h3NU0Btquw/hLVu1XFFPyjFNkmSmEmfVBqytw7ZpmqzPK7C9nEYpGyV/OHDWfxz
         HymgiL0xA5pgmeT4jKY9taompyWs6xeQTVWq9dBI0e1efY6Pd3Gg3lQcQT+d+8HI9Fj3
         Y61KCD+vLAz4R21tH5VQm98co7op7tXGcX7QBKj4ZCsz3tyJjUc9lDfFxaITurCCccbB
         uP2TFiy1d7bSaxfu5zp7/a7qpbcHXEuDAHOq/8XDF9EnQTITOqATq+4k3zGfs9dw91he
         E+QA==
X-Gm-Message-State: AOJu0YzLGcIsGOk2VpwDSrBOYcStO9t9V/4AmwSqDm6WyA5xmqHxTVLe
	HMnLUHfpD5JXO/9JQdwKu+B/Wc3oT/gJxbPdqc1l2BM2auUiNowjZsNIzJL86BrPHsp1STH1lgd
	0t/Zvlcf4kQhDt0LEsjf+oeD6Mc1odPr+vzYiBHTUAik/bsFumlC9MWGtRlEZuOktCii35IvKle
	5NsNAy+fvwdQ==
X-Gm-Gg: AfdE7cn+6Vs0mG97EYZ1qyzrIJ+66XPtW1pXqu6LAkpooPJ6XBTYDNpDIaXrf6SB+wT
	MHKl/eNqQNIPI7oAz0HgF43hgAvxQLansfc+fNDXijPkEFyxbFLZBVvDB257JQmyxl2a1gMkqNh
	ekuSV/YQVvIYFCzEZxD67cMMsQyvPkj0QKbqhqPoavMoWJSmgae7RSKAAxR9KaLQOknuc9l6VKH
	uBm7UWoRqK9aWAXaMSlmGx8zJ9vRk2X6G42/HwGReMU8Lkk0DS8nYoH9lKhEI/Dbn0ZYkpP+PL9
	WJCFQ7ryRRlQ+nDFtKCZdFgHvWXo+Yy8bkZKeCZHilZBU6ppmT4IZpBjaDmgvPRVC9mz5gAWYV6
	kUZ/++dazdZopT7QSKdVYsE8Vbg==
X-Received: by 2002:a05:6102:448b:b0:650:aa33:5dd7 with SMTP id ada2fe7eead31-72a01884599mr230016137.2.1781798408183;
        Thu, 18 Jun 2026 09:00:08 -0700 (PDT)
X-Received: by 2002:a05:6102:448b:b0:650:aa33:5dd7 with SMTP id ada2fe7eead31-72a01884599mr229986137.2.1781798407737;
        Thu, 18 Jun 2026 09:00:07 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fb3c7d9sm1023505e9.7.2026.06.18.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:00:06 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 3/3] README: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 17:00:01 +0100
Message-ID: <20260618160001.3634123-3-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com>
References: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfX6yLtgZ8g1Zxk
 8qe4mJ2x1TyaNJp0UGSSuQosdxNGC7bRmJFBE6Qun2zYpE6ahjZ2G0RsT1tMgQBtf/lXvep7t4j
 Od6sY/ik6n+nrVtNY1KFa8KlMG5e94zmTItEubqS2A6NiDZFkjQgitU8HRO+kvU9GGBSsGFD3Pj
 TjMyg6KMpg7vRTjYOndTHMjUCCDbTnUUsKw+PnNzKfgeqsGMZsYafbDIffXFT5GCtyiKtB0Dxu6
 Jl7vfFRDcY8QKMZlnjfx9K19TIHmnP16tpb77/j8+Sm9O0b3lsHqI1fjE0btU/ZKE7eZpPYsA8m
 JbJ9g3AsvbJjk8NrAJ6gF8azv9bj1K/rH56bw8YJKdrNsxXc4s/rZF27+VqNGt6qM+Qo6XzKImD
 rVkj/7tdejsJ6GB3gOOFmWkBkP3lO7qEj6gddZ5pgzArL9tpKMHSMMPTVQOGpwNLjKSLS7zdu4A
 rBvvOLqpEcoYDYA+Pvw==
X-Proofpoint-GUID: FRvAHTed7Ksg-xWWMUctdTNcSqvcDrV3
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a341609 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=SVEtYPRGmVSFVOtmKFIA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: FRvAHTed7Ksg-xWWMUctdTNcSqvcDrV3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfXwwZXcvR/s1ws
 oEUp/6wflvMtWiy0tt6qGG4v/jRjLZbUdty5O/aG3+TrHk4DuWeMBrhmEdgC085cE1RbfIt0MDB
 5YRBUCpw9aOJdxMdyq8W7TQorf38+Aw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180148
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4249

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/README.md b/README.md
index 16c0d8c..deeca33 100644
--- a/README.md
+++ b/README.md
@@ -8,6 +8,16 @@ and officially Wrynose supports only that. This thin special-purpose mixin layer
 is meant to provide a current Linux firmware for Wrynose by backporting the
 linux-firmware recipe from the master branch of openembedded-core.
 
+In order to make this layer Yocto Project Compatible, the layer should not provide
+new versions of packages by default. Because of this, the recipe provided in this
+layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
+variable is modified. The default value is:
+
+```
+# DEFAULT_PREFERENCE for linux-firmware provided by the layer
+LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
+```
+
 Dependencies
 ------------
 
-- 
2.54.0


