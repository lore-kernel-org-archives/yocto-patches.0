Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B885C55838
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 11:48:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14499.1785844076736491760
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 04:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=UfoBoTKh;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=eCCE9H01;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CJEw3373762
	for <yocto-patches@lists.yoctoproject.org>; Tue, 4 Aug 2026 11:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NGdFm51J47H
	dj+Vd9WZBYIpHSxI9q7tPM8OlqFzz+EM=; b=UfoBoTKhvUQS1ZtbvTRD5sjg0vT
	GuS16C1Ty73pl0GrM4p6MYwwdPDf3S45v/utlQMryiHSeTuRKFy7A7lN3f0w1z5+
	oW3seg7p76Zu6+gHmSMrNPbMDABeMULID89vpL1JfRNA/ztguqkyk+6dZJGtuW5f
	BJaUvpwq1Y0v5OuCicX7fTvZUIqZQJVzENEt4c/GBtZAaK2B8hjMXOoa1V4PoGxO
	V/t574WPwu+UN06ugvVJ5+lhbSupj68pcQ3VGDCZOwdwHZNr9WxI6Jyib7rXL0Wv
	bpgwzGELXhsolVFJtLDWQGOozKudQk4MWZaVmVBae58lYNQDCJC2KwE4EkQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3r40tk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 11:47:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930edb4362dso364501385a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785844073; x=1786448873; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NGdFm51J47Hdj+Vd9WZBYIpHSxI9q7tPM8OlqFzz+EM=;
        b=eCCE9H01YaQsGkPfOYoA3xDmmCGFwYU8B2MNKSDzW+cigvMoLS3s1ydc8hX2+gobW/
         S/RCgvxTuk3HjMxD9n9kZifumYSLUnZfB1DW565kAo8mEBpXzGo3GBagpya1veziMcto
         KU53UE3QmTDkUibFJPpWnxff5OiY24qmJ2XkNBY2Xzu5C7v5MoPoJaj8O8Pd4WI6dPkn
         f3kuHAH1Ep/bRmDArqrK8BNJ1o3TTLHXRRuj9RHAJOKYu5VFIHjifbjpgsuHSM2iPPvZ
         1lGvQmrYamj31ZA8VLo4g5mZIV7aJnRXLeK5bt5CWH5fnnrhzosTNdf5KSfdRusSWB6e
         E/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844073; x=1786448873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NGdFm51J47Hdj+Vd9WZBYIpHSxI9q7tPM8OlqFzz+EM=;
        b=sVm0p9uWyFzY6W/140+2ZHr90jpbsNARIHKPheV1+nOLtVv/g+K7uhA65epPaveuk6
         wWWaBdk3efPWHbpH+FcJeH8yB5fGnzLd4uMpg5mjDWbGw6JVoU/iz+0bTi8vsTl7QQd/
         BvaZ6WJGUKgirqLvSw85hh7v4JnaV7MAAelYW9J7RpFfat8yYCnMNve3RCUrFlimqXnL
         uio2XSQ3C1x5RydLvXBwKQ0St1ge2GbOcEQ0xwUr15GoDbUCrtOkJ0nMBMMPRbgbU4Xk
         NTO2uClUrmpKD9ZgScf83sn7m1QZREv+A+LR3tOx2E1Q/uqEhtv9/Ok1uPxJk2q3gKIv
         I2Pw==
X-Gm-Message-State: AOJu0Yx9Yalgv8pmntvfwZaFIVYQfFYTevK7HSi4BJTzor3TvRDvQah7
	wBSSpeTkybFgfla7J7iYgTLmxlNHxT9OQ/KYA+FNZMPOQvMjssCcriC39fh8DXz37DpkdCiTnYd
	Vg2udGMRwg4jAxb0OmXSBxPCDbjYdH+GYIe7CKO/hDpYrQm/N4j68016EWVKcD2JbVRooctU5YU
	5I8E4QECeVFg==
X-Gm-Gg: AR+sD12Nx21091/RREvd++MmC8cv53F/fLu93h9fqnZwExbsbkL56hUK+a9hYQPO179
	N45m4PaP1mqJhy08ISzN3thnsAKQX2UxOpMJEcSk3LjoBsGxWfumtGvQVw5CFHpOlU37w12ctm4
	O9hdWVMrIbpdrzz9MP/9L/vzA1jUuXuGOGMzds9/afNOHp9sifUBaef7oDhCYgq8RD2Q/fFpHu8
	SgOhkFiYvRy51o7g1gK8uVhLFl/AOVey3Cphm5QVuBoPrRg2CpQKI7ot4xmmGX152F5B/6wAEV9
	C5cLoH6NpuoxjbSUWX4WM3rYe27XHl0pnLqZsB4BdAdPgWKyQQJhBFRO30aVuqcSDXBZ52p931u
	IpgpXS1SF1rb3i6vM5SmRTFE/9KBoYuUoq2MEvdgHNmNTNurSotPPqQfh7YXLMFzlLVfWz3FMXk
	No7ufdP25GM7gU8A==
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id d75a77b69052e-52b5669e087mr272447901cf.8.1785844072941;
        Tue, 04 Aug 2026 04:47:52 -0700 (PDT)
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id d75a77b69052e-52b5669e087mr272447611cf.8.1785844072450;
        Tue, 04 Aug 2026 04:47:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441eb7sm2636129e87.47.2026.08.04.04.47.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:47:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 2/2] libselinux: enable nativesdk
Date: Tue,  4 Aug 2026 14:47:48 +0300
Message-ID: <20260804114749.625810-2-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260804114749.625810-1-dmitry.baryshkov@oss.qualcomm.com>
References: <20260804114749.625810-1-dmitry.baryshkov@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=caPiaHDM c=1 sm=1 tr=0 ts=6a71d16b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=Amk-IPpudhwk--rE818A:9
 a=ZXulRonScM0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX1TMtXrsz8JUp
 jaZGiiwxSSyXyF2F1lsYMbj/iO8nkjcDSIpXQ9y8xas5efjTee4rqjt3XOHedOq/kaJO4YG3kG9
 0J68JqtMHr7aIGbDu7oNyF3lSf0LmOk=
X-Proofpoint-GUID: OZAFbc-1PEvgyBI10l8zQww7tGHT3c0r
X-Proofpoint-ORIG-GUID: OZAFbc-1PEvgyBI10l8zQww7tGHT3c0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX74H1ESzizxkD
 AOietMxuUA/PUy5iITDBbI06L6Tmzak0/nwpQtsn58W7PQpm2F6udtbDJ94nh875krQ/xyZFDrd
 Y7PWQo50zZFvF9nazSvBl9e+iBDPM3KRBlP4X6+HFHzNpCPPLuEhm2bWFPpZ1+G9f+7B/0+fSYB
 Fur/WFbnh8qgQ8G2o2g/Kfplbui7aN9AdSkExVsVxNENR128EInxwEwjS8KMeI5ZLH0+VTzxH3W
 Cc3HCdv0MyPkVExgLIZzeWOzbmBH8gByc4+DeohJ+wF7UaXtVJglyA5+OnwrcvOmnu7BDEkLQj7
 j1mka5hhGKEFJ4L6Nn/dawFSJp9Ov7aKiuAQ0DxCpeEF3xCUNbrxO7uo5xSPhroTclqQIJxTbZ/
 ja5Pk9qNzD7tV+jJF3Uv9cS1Mv4PA+9ie7Qc6CiFIgrx9h9gvzSY5JmQEk8+9pNXBTP+t7zZM9+
 YREsO1hy9UZ3KDBd69Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040094
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 11:48:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4619

Enable nativesdk class extension, letting libselinux to satisfy
dependencies of nativesdk-rpm if SELinux is enabled by the distro. The
binaries are not necessary for the SDK, so they are explicitly dropped.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 recipes-security/selinux/libselinux_3.10.bb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libselinux_3.10.bb b/recipes-security/selinux/libselinux_3.10.bb
index 86c9168a002d..94f3fcdf861d 100644
--- a/recipes-security/selinux/libselinux_3.10.bb
+++ b/recipes-security/selinux/libselinux_3.10.bb
@@ -32,4 +32,9 @@ EXTRA_OEMAKE:append:libc-musl = " FTS_LDLIBS=-lfts"
 # sections which are not affected by -ffile-prefix-map, causing buildpaths QA failure
 LTO = ""
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
+
+do_install:append:class-nativesdk() {
+    # /sbin is hardcoded in the Makefile
+    rm -r ${D}${prefix}/sbin
+}
-- 
2.47.3


