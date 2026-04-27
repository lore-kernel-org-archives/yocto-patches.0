Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39AFF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 06:20:45 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36756.1777270839475976485
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 23:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AaXo++q0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=857708df19=rong.fu.cn@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R60ldS3525652;
	Sun, 26 Apr 2026 23:20:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=MscwQQS4D
	BpN2r6LVKEbw5Vow+cakxtxl/gY7T2vWAk=; b=AaXo++q0egp/UShvrOcc9IBF6
	9kXJNV2ZTrmGOs8hOGcRFGuzfXetCREkd8s0Tevfb3mC5usN99jJmSzrvJKYpqIE
	76rYv2rr5cHD3zV3tBzIuXYyOaHM0JShu4VqNUS2uXnf/dg0P1zc5ZTvhjUshR9b
	4iXvGxgF7vjHfa+ViYBUFYv+w25i6S7/mee0o2IOIBqQ5MT6NghTdBrYassUoXVr
	b1eCKtHLl17MkNGmFyeKgoRahIyY1ZNNrfnG8YdTd93y4duhU/nDtAxCO0xiWKKD
	P2HTvlW146WLLqZ+ntj5thxdPZ3eZjM23mEMTiCMzRVa4ax31hFbfyaW5+CwQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drw4j19jm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 23:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0hqlsxyV1sLEtG2QsPsBYmdykYDSNgCgwy7H+CmNbuatKcjM0liNKVsJ3czAuvGIq27kouaedVEEaCzNWgOXGxsjU1RSOStoZoMHqDFMsCdZidamcCx4Z7jk8jBadCeu+VO9+Z2qt8NxrbYtKuuKhczIb5e6qjya7L+jVkWC1b82rBUPmy2b7G+twtrhRh5STM+F6NUXt3hrSFnRbWc36Tsqy0+c32mKkdHABu+dka3j+/bAi5QAUHDJl1OyOR/XBkYEdr5DB6oswRgAaaF7nCyW+mM9UdiGDOJFlY823H56qxY/JtTaEl5JZxyfIDN0NvTOVlwv0Y/htd9MGN1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MscwQQS4DBpN2r6LVKEbw5Vow+cakxtxl/gY7T2vWAk=;
 b=ZHZmoMZBKuVpnBFklXntqdXNvvSnXGS5EodranPADGf3eNsyvTo/bMljendBf5J+5kZsMuTGYCwhlVgrhqi6TuYQd3vKbqxHliJLvpf19sd1qchkqFt/6n7BqPuGuMeT+xzTomJn6eBIZYE8e+63ZEBJp1ueRnC6Zyid8X3clw+F5Jb9cke1cUsJjc3MOF3givokb8DmCHtbQ4QtBf9AY0gwtqOFGNLUjpTSbXzt2cStj7KLnmPp9O6ILdeH1D7a6gUoTm8mDUjpTm8pzC/ixQHE6rfTjmf79tlHmr2b7YXR4TbAQqpR2yHNYhA612T1qSf/mevfFGEl8g4DP0wGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 06:20:33 +0000
Received: from LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36]) by LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36%4]) with mapi id 15.20.9870.012; Mon, 27 Apr 2026
 06:20:33 +0000
From: rong.fu.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw][PATCH v2] mingw32-common.inc: disable meson exe wrapper for mingw targets
Date: Mon, 27 Apr 2026 14:20:20 +0800
Message-Id: <20260427062020.2393600-1-rong.fu.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To LV2PR11MB6069.namprd11.prod.outlook.com
 (2603:10b6:408:17a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB6069:EE_|SA1PR11MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: d21fef21-3280-4db6-8a83-08dea4251682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	61v1RxJEF0/pbCV9qcE/95xPoiayplcOXM9Dc02vD/JGxO6nbVVwcNr0/p6utE0oGwOBsFycgJ2NfWOcV6fwd0GPCe0ggzonX00f5C8zCpSesMb7s3zDOyWwZBHc/I4fe58jScTqYZt7qxzPF+U3vAv4uJGRHCJYUqQAgNjh4s+HrxAXsRvqoqmktXDLorNCrJ1ACq+v/P8QdEzLmyKNRxJKtelx/jXERlY08ZYQW0g/qYFrv7EdvN4P1oCOdHWl3r2HXq5Zw/jHgdrSlFhSJcKEoTPafgq8iKsX7pTqjcI/KrCQ6DAukEC2ZWEvoui/3Qv1WgVvKkYpkcBIWbIY9LUixhPRt3JE8zajRzD5ekj7OiywQWkwrpf4TaE0QCNFFshGMVC8taWeU53oVl9UzJkqnoStvNt7pL/peEGFhR9mIsrIa7kM27h4l8RaKKTuHj0HR5aNpM694Ggp1CV74dAFekTthvFHkb6QkUb7Z/SeC9QnfYrLHiN5HbE2f0FY1S+/78TsOIrkL9jdjMrwvf9Vt3NaNMpXAz2zwl57Vy1fjZbWGAPgbtUjOWfdSJgnRRhtowfCZbaRpOzXHMMA649ez331Scd9KSDpz/QyGSplKKatHpNEcaUWXPWTghdyOhqtPZuYZde1MlWIGMAEDQ3p3eHljheXFbCTzO2vpniGvkD6vl3kiTx87ReUhl3eVMTpLLcq+OJ3ihbIFkWSFkjUEoJ8QtppfL+REh7rmo1eEmlLJhO4upMhvSURWgqYdSisqpTHjr/jO5XsYcDy68F4/Vw3xpvaHp/elwsA/K8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/06VSnAxs2PQRYgBIZAXyhhGkaJ7JKL5NlM3yFQzaLqZg4zS64w1q2tj/HDe?=
 =?us-ascii?Q?4YHHu52hdh9nqqiZKqiK7Hg0qZob6ywFiv5r35wP7enRf/EPNtqED8wcOBcj?=
 =?us-ascii?Q?WHp1Eiaiq94rTDZPuTp2JTCKtvEiYv87p9MAymmx7CXVS6PFkQrMbcfykVGM?=
 =?us-ascii?Q?jJk/fnBPQL2mXS/RO0yjOe09FeX5fCG1QUu6ptc53GhiLtQvRDcji3TbcKlP?=
 =?us-ascii?Q?UuQp+SsY/L6X7euGBy6ncNrC56Ndi7hpRDhr6STS4AUC0go0Ag3yO5DumWD4?=
 =?us-ascii?Q?/1vbObNKZwbKNws6ZeYmpUh2HRin9vSzG2QRhoCXIrgQSjZ1Rybnz2wbfvmb?=
 =?us-ascii?Q?5IbzYqEkfecX5kaVgt/xzMrgRimQQ4f7gjq4uenE9196Kl7qvz9IgwgfNtj4?=
 =?us-ascii?Q?p7l+FNE/Ro/snaX9is2RQyYbvulFWEPGVcruRNvCBpQhA6nvEzFUdMuwuKBC?=
 =?us-ascii?Q?sJngL80VLyEp6oy/rQvSyOm7y7eSLn+toWCAIwPNgG4WuTugG7iodNMZ1C3C?=
 =?us-ascii?Q?8dZG/plqQTEGmujBDp9htBo71sXY+i3PmvW6Gr+KOATM5SCTbdaIUegold7D?=
 =?us-ascii?Q?3iBKhYv7QPFi9ceMzWsNiBrS5Wt4bmeVkPp62qB04RFxPWxBmNd/+M1d3BnY?=
 =?us-ascii?Q?H8HAcO5yynL04f/AMiX2IrKTvrX2Nsu1kT8hAAtuWqHznEG5/5Kw+2NLSbke?=
 =?us-ascii?Q?wOxaDaf3LYXDKgvT3w99kGEfbcRj50h+/bsXMTI6QvbEqYTX38P2gTIGn8rz?=
 =?us-ascii?Q?w2Tl0R8T7GBgdNwg0VWzShvrimtd4wMBV1JenV1whmgBQrZxnJ4E2pNDXj6w?=
 =?us-ascii?Q?MDgAvtJ5DK3cFekRqT55y+wkCobf3s/xQPFYgFvSNat7E/Bf7KwDFX7O6e1q?=
 =?us-ascii?Q?2lsBRTXb7CU912B+Lftv1rycy+ZV8oaQrhyJkWn8vJVIf0bAa521CF2USaoz?=
 =?us-ascii?Q?ZmrtWLmJqPLM7LGXT1xsgq3Ox4cz26/RuSotIQpRddOMtQ7+TyhkMIQY9u/E?=
 =?us-ascii?Q?MvBVFyinOIgL5VoRYdKg7tqyAwlZpBAIbU34+ce7yEhQsxG7X8QdtdIF5Y8S?=
 =?us-ascii?Q?3pJclV9XCmRTJ++FWh1ZmhnpmKn1THSF2Ygkvi41DxIMyPUqUswjM1j2/h7n?=
 =?us-ascii?Q?c7WKuDsCo8CUn3VmVwk66NQXNml9UOXo9tfAk9Cv1dAJV56R7tDrC39HeIFt?=
 =?us-ascii?Q?7dSryNka6qbFS14vgxDrIQG904vIXNFQSHisuHLKQ8vgtB10ltSu12mnafC6?=
 =?us-ascii?Q?qfgqowmb18SzdYpCLxNh6ir8+/kpPLan8txyRPRcZNRKCTfNmDLFmnCYZoqd?=
 =?us-ascii?Q?0C53ell+Kqa5QYcLawbfqmIGtZh/rUofNNLK6aKG8fRdZHU+fFzFKGbJrbYw?=
 =?us-ascii?Q?K6NcjRc7qGR3lgWb0amT//0QSS5scTP1RSI87pMrIS3LKd46GjLDWxaa5aMt?=
 =?us-ascii?Q?kVa7rsgVRXqeMUIellLJYmFnaYDuXIeT2UDwbklp+pVSUMdNZ3IbMHcI/NhD?=
 =?us-ascii?Q?unDcS1cRDdXTCYfMtn5CrP3rEBteLUVLUiyVnlltDxg9mGKadarnYn0024m5?=
 =?us-ascii?Q?/oVdoLbJG5ZKGWaNRmZ7mSlruNrDV5Ce6MfkToKj7YoXsHLqZSLEDIXMIbWc?=
 =?us-ascii?Q?KoqRh3QBSa1s52QiIpv/IghWcI+2WHuB1kx3C0c8JKccFBPESnY8n9j1IYRb?=
 =?us-ascii?Q?gBuFiDXJAV5FXHTEX3Bo85FzoIIVxQ5q2mD9byq8JurPor65h/sjD4wRdBCG?=
 =?us-ascii?Q?dFlplqJRBQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	LL/2wAj3cneAr9w5nSPmtQ2x7uOCJYjZeuOFyZEZsMayKLSf+fiLkPjYjSs9sZMQ3O5Us4qnYYdsKFgPERo3supeqjMjFXf+hsFVS0kH7M6hauEY4f+shIWJLMpulmIhyFFHR22y7LXAwPX5nR6j1EHA316FJunWOUKTrREkbeksdzGCoIU9cQ5mwGGWwplCnP6NfrNr1gBlZo7VeJI5GIFwmt0fk85b3zuYDPgHMcNjFmKARy7tOzZKvGDDdP2UwI2LI+8hTPdQVLSv8ua78iqlCxMoKCUEgMrMI7YsZGscKzXIHEoKuLelJ66CRJ7W32dYZEk5mcCHAiGWnplVpg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21fef21-3280-4db6-8a83-08dea4251682
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:20:33.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //PGXl6AsOjugh6onpxKCLerKgqBH/7wLqK8bO1IyAMCgOGa0VIOlsej48qOB3VuyRwo/YP9XzK9Iq9r1mbJ3sA4mDL/mem7MWPHck8Qvbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-Proofpoint-GUID: qvwNR9j6lJQHcmSFGkaNcQmQONxsI5IN
X-Proofpoint-ORIG-GUID: qvwNR9j6lJQHcmSFGkaNcQmQONxsI5IN
X-Authority-Analysis: v=2.4 cv=Iroutr/g c=1 sm=1 tr=0 ts=69ef0035 cx=c_pps
 a=ksElJwkXcxqN7TVlQt8uAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=5E7aB64u_DvsIhRDXwkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2NSBTYWx0ZWRfX7FMZGqWxImLf
 KU8t8qdkKjWqQDYDg4ev0ody9nGhzqOgT3Tm2MGoAII2vZ87pbQ40groveqhhY/k5D7RoHt3kca
 VB32XnhoApMX9q5goOigm3ng7+5riE4UicqzzjzZuR9N5C8r5T7MUWua/OKJe0gZhWQYnZtxN5A
 XXOEJ9YaPlRzSaeoUmO7w8j9UF7zbaOjPqXHIMV5UCQjTwlgLZ66vz3bOgV5sCr8qlC3spq088Y
 LJdhBMrpvB729U7K7cMk0wfMXHxw0GuLltMIDiYumU0bt3u8V0zaXbhzERm1RBCC11UO4rjdJqk
 Bm0gbmsOujW9Mj3w2/CAF4IQ1cVrC/ieYbF1Ord2pCfdgylxxky5d+qbh+XEjEpN2yZXQ33vUhG
 znfuT1jpqHB4cujde5NCZN9gqacZmb/TpSCjE+gHyvfYWxaLhf/WJ0ojO8ULOl2lGXWeA4NtyPZ
 gUROKkVF2AkQzMVCLtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270065
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 06:20:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3828

From: Rong Fu <rong.fu.cn@windriver.com>

The meson bbclass uses qemu as an exe_wrapper to run cross-compiled
binaries for sanity checks. However, qemu-i386 cannot execute Windows
PE format executables (.exe), causing meson setup to fail with:

  Executables created by c compiler i686-w64-mingw32-gcc are not runnable.

This affects all meson-based nativesdk recipes when SDKMACHINE is set
to a mingw target (e.g. i686-mingw32), such as nativesdk-dtc.

Disable EXEWRAPPER_ENABLED for mingw32 to skip the qemu exe wrapper
since it is not functional for Windows targets.

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
---
 conf/machine-sdk/include/mingw32-common.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index bf3f14e..6014c51 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -57,6 +57,9 @@ DISABLE_STATIC:mingw32 = ""
 # disable security flags
 GCCPIE:mingw32 = ""
 
+# qemu cannot run Windows PE executables, disable meson exe wrapper
+EXEWRAPPER_ENABLED:mingw32 = "False"
+
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
 
-- 
2.34.1


