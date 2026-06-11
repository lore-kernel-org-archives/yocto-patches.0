Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D46CD8CB9
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:13:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39387.1781158419335035151
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 23:13:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=L0jK2W18;
 spf=pass (domain: est.tech, ip: 40.107.130.16, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBpVndk4cNrA+aBN+v1uF4Oy+ad82YT2kbWBpDA5xqGk0z1Z4gOeKjUSoYcLoPSudYOBRpR9e+vnBAcWW4Wo/OX6WSpiFeIurRjHMGMoqP35AEDfvhzmqvCuapR+loSSa7P5FWhtAS3YWxauVbfRkFP3D5Caqm+EqBTnUrmJ+xOT1lwtHBYTa3EXUlBnMb8KYhDPRgtKGwcSzjZR5u3BE5bjH9G4xF+/H2s5JA4W6w4UFObVyCIJjZtzR3wZ6BRIAi8L0GBJDfrAuWSGCkUjYpzjTUmhR0uoo0Mv7pY7Dq7WNU+dkyXjaDC+Ov3lJJRQLzZwgA/nMKKkMUj+I+KGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atvF2ul/mSkG8KCeGfKXrNDMnePDmOYqtNyld9rIv9Y=;
 b=qIFnYRVLe35MQjlr67Jhkdxsr/1ShcuRSSnAYv71pMhKQzgLTdmztzK/VQJeKzu9zIBURIynqYXQnT6AqCi6IDuG8AlIS0ZZhKBuMbyDXzEko5wa3yPhLUOthABor9Bxe+WG1psabxdWP/bQisCIhEVE3VWcvu72Aw1ymtRBObNOsOs08QR67iAt0hq7B0Q+j6HyAgjV6Ec+q5YDox8xn0CV/bOR62m1DPTzGgH49ukpNQdTOTyrW8aPh2MUdoSqmWDyK1SmAJJMvPsFtovnC1IJtepF5jEbbXED1vOrOyx914jmJ5nIHkLM5Yr6GXnPwIK9iSSKZHD16Owsb8luLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atvF2ul/mSkG8KCeGfKXrNDMnePDmOYqtNyld9rIv9Y=;
 b=L0jK2W18Z8KFIsuoqSxOc5miSLzVsqGAiVRqQGewD7S6LGQ7hpzOx8UKK6BVPnerIXT6Xshyx13U3ti4bJ9mciQiwFIKXCjeL063K0n7xkDCCAYu0TgRht/Nl1vNTHUvBeRLtID84eR3veC7rard5Yy5ato+x5wulCYAh1KFrPMQHv4x/CgqXgBw7eA7s+dNQBrfWE2SBLE5+foXiv6Y7SS+1e4Vlm5BNm8O4Kvi9DwaUI+D7nQbTOGJ6game+8X8CB6MfVu4KTV7eL/CdthSLROznoWTKgrKVwH/8c9TBuu6oPcRyw2uYON5Jug6ifNl6oE7xEJl8M+8SSpSkm15g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 GV1P189MB3003.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Thu, 11 Jun 2026 06:13:34 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:13:34 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: yocto-patches@lists.yoctoproject.org
CC: anders.heimer@est.tech
Subject: [PATCH 1/3] steps: avoid shell when writing repo metadata
Date: Thu, 11 Jun 2026 08:13:28 +0200
Message-ID: <20260611061330.733392-2-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611061330.733392-1-anders.heimer@est.tech>
References: <20260611061330.733392-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU7P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::30) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|GV1P189MB3003:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd2ae73-ae93-49a8-cded-08dec7809189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	iRrEWUVR8883HOWr3D7n9xwx2aTvJJjR4xqRax+b4ntI2vbnuNCD9/ZZYkx5k2V2x4Ig3wK6YPMuHKg16SiIwyxrYxmBudyMcEHBdAgBI3eQz6YmDhdLKX1BzEIWVZGeOIem2l0mG+6Xe8hKBK1LOCu8XrUJxbH2ErlLf2maWqWbzMza9PN5RHz66BCrjwACS1QqTUTdQwQKbOE71JySJ4qstwUvZxQKzZytJDONrXMfv5H1Zty4UnTgLhXf7PI4wngYWBmw9QN2bKrjJuFSyDYizRXjYRYOWMYC9Hkqqhmu+573nI3KXeOjYULuE0ehgIUq2vqEwrjy3wJLIVG+e7KpHmYRUJwe5sB4/2BK0FaMhXc7o1X7KlmxgwCemseM6swAKUsIAlRIK6H6LQI5bO6EGGz0FOO+/EvxI97h3wUv8abS/KTZQduK54D9hBFp9uheuPYxHwG9cUnjIBAp89sKgnBrFYE9H50PWySZTeModXOLszuSpMa0brNHHuFAP0muF8bLVvrQ2WAzvUd7BuKdpj8HAVg89viPmXIG6mYKP3EVSL0uJwPWkRoT62QqOrJxQOCI+7WxyCxOwRUJ9waSZZwKvHgYS9k10VPF4uyQ+zIOwjP7TEfXTS3sdzYgVXynv9ee16GQoHKv0LA1EBwlK/xi17FgvONVZY+FD82ZJjr1GgJsEIb8Kb+kEIBk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xGncwpp6oBK5VIbPIQxGmuaRBOlFufxAcsyDnYlKoOtiu234tMRAuV9RoX1l?=
 =?us-ascii?Q?y2UIXuFIeWB/VyufC0dlCZD8BNBH/j2Erd1u4lSCIZURRTIv0tWD9wzpOKwE?=
 =?us-ascii?Q?m7zbKFVyhLd9RT8QwEUCfxdFqMLBp2QwSF4dtrHxks1N2ek9kjasIj/+Of2u?=
 =?us-ascii?Q?TmsJ/GNn87U7j4kcNLBxrJ6c65EAiSi/HLpN/y4YWS+gufzNT/3wO2ZH2ifr?=
 =?us-ascii?Q?qV4wvPI1/hUp+uf0wXjXxI0t1Gv/B1fJ3SnxiROV2yjqizmZgHw2efICIBaE?=
 =?us-ascii?Q?qj6PL4TsZ4CusPRyaAZfkn4eBs8VgMBrY0xvwrD9CwaYoMWtRYAyASfuGf6N?=
 =?us-ascii?Q?yl9S3zhp4yuKzv6z0/c1uVX8zTygWHHtrmtyRssSU5+Il6Dq1fvCpINpsBP0?=
 =?us-ascii?Q?BfhUQgGcLst3icWh+1wA2QTlf9YjlL79DY9Ea/pW+2vcQbHIKknqjXRyNJqQ?=
 =?us-ascii?Q?S72ovVOKxS6mDJQX/WxdPWEblRCbS0vVuLyTOL1YWEpVxGMhdr/XYofJH/IH?=
 =?us-ascii?Q?JNsldi3i7LKu00bnBCdiNktm1brMv3g8HLWs6kHsBNDTagPrB6GhF+lSp/RB?=
 =?us-ascii?Q?Su6qmmVGvx24drx2fDwaORT7GI3QqbEGmXEA+0NphRMTcTdWVYFy3BEorANe?=
 =?us-ascii?Q?FDB5HOzxH/hadL5gCXMONiJzBGpOsSSdNlKgGoT47sdS8BYotYPHk/6BOgwW?=
 =?us-ascii?Q?9ZypnFAIfzNa2FRaKKIUI5nk4rQHDjUxncKXEdmK4cQqzQmeFm7i7jW2Awpw?=
 =?us-ascii?Q?rtQH6bnCS8bQRTXIL0MX4pYdJQ1L/fEdpHOmzFv89eCekO1mR298asrC9kAA?=
 =?us-ascii?Q?GX4DwKYZttXY/0qRrKA1BgjQTTOpjkFg3F9967s3VsL9fiCb89MmJSOzMdZJ?=
 =?us-ascii?Q?CvwwiwyS0yqKFA6Gictn5VTBx9f2VCq8BPpWXfD0kfSdERqqUfgfqLoSGQPX?=
 =?us-ascii?Q?zDMFOMGef5+ePp49FvqAgxfbTIKEywGYnuVLToWcLqrcywEWLk9fE7mEAAgP?=
 =?us-ascii?Q?JWLx/fSjByiApCmcb+z7FbFn6/DhAmkifAKWPgbGXa8MMPKddPqJxdC+/+OW?=
 =?us-ascii?Q?BRxMf5EMJBYatF2chDNjxT6arebk3uuLJt2ZLxw04NwEZ8EDDQN2eWJ7cnTi?=
 =?us-ascii?Q?l0vxwg+n8s5Avama6q+cmRS+Np9xe1YsmmJy5yfPDl+qDXtvuvIT6NlvE/DJ?=
 =?us-ascii?Q?DZk09xgofyze9kb+Ft3oTxkHO+bvsurJgPGJwfnX3Dqy627oh/qCvqq/IHRB?=
 =?us-ascii?Q?+0Z7JYWr6y0vmVq2XTrzD+5dJRA8DTAyk42Gl1Dy3razTOeyN2T02Zzd16nD?=
 =?us-ascii?Q?xjw4rXdee7l3aVaoMyd9posoBAb4aTBuuJYAIDYgjsT1ssik7NNi8iQRQON+?=
 =?us-ascii?Q?q2czrlgXazKqvtVGnNO0iSRujoXVeVDGNjICi4j43tmI4vltXaDLa+xhpUTx?=
 =?us-ascii?Q?FVDHVQksTdy3qqVobSuzK62Yi4oy9LyENGhqok8jjkAHcg2TfQSM1SaUn85D?=
 =?us-ascii?Q?nAFMDU/OcrNBsZBGLNu6cXkSAek0r4DDdpGDbLyex6vtmerJ5dqyj7aRh7hG?=
 =?us-ascii?Q?oaHPevsQWVIcN28pEefD3BOHQpzNPPgO6pyUXN0b9l+5z0RqHJje+hKMnp4D?=
 =?us-ascii?Q?KTNy6Pd9C0P4zC7TsyehRqP+c6rK5xEDns5yB+C4BfpGegcvU0xQIGMgeiFf?=
 =?us-ascii?Q?VzC6GmkUPleqmpYKD3OiJlNc5sjvWvqYHmGtQG40RP82NR1vZRcgMLH1JJ6y?=
 =?us-ascii?Q?uwsUCWrpsQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd2ae73-ae93-49a8-cded-08dec7809189
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:13:34.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf7RlGzfJwdqVQ7O1KcKfwrGMJKBSfIt0vIMHqSJvRw1RHiR91/xRjHu/GLVT7POCSyMu0+reW+aKkOIVERc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB3003
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:13:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4205

Use Buildbot StringDownload for repo metadata JSON instead of shell
printf. This transfers scheduler-supplied repo values as file content
without shell interpretation.

AI-Generated: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 steps/writebbsetupjson.py | 19 +++++++------------
 steps/writelayerinfo.py   | 19 +++++++------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/steps/writebbsetupjson.py b/steps/writebbsetupjson.py
index da8d434..e1f1463 100644
--- a/steps/writebbsetupjson.py
+++ b/steps/writebbsetupjson.py
@@ -5,9 +5,8 @@
 #
=20
 from twisted.internet import defer
-from buildbot.process import buildstep
+from buildbot.plugins import steps
 import json
-import os
=20
 from yoctoabb import config
=20
@@ -15,11 +14,11 @@ mappings =3D {
     "oecore" : "openembedded-core",
 }
=20
-class WriteBBSetupJson(buildstep.ShellMixin, buildstep.BuildStep):
+class WriteBBSetupJson(steps.StringDownload):
     name =3D "WriteBBSetupJson"
=20
     def __init__(self, **kwargs):
-        buildstep.BuildStep.__init__(self, **kwargs)
+        super().__init__(s=3D"", workerdest=3D"bbsetup-overrides.json", **=
kwargs)
=20
     def generateSetupJson(self):
         setupdata =3D {}
@@ -66,14 +65,10 @@ class WriteBBSetupJson(buildstep.ShellMixin, buildstep.=
BuildStep):
=20
     @defer.inlineCallbacks
     def run(self):
-        repojson =3D self.generateSetupJson()
-        layerinfo =3D os.path.join(self.getProperty("builddir"),
-                                 "bbsetup-overrides.json")
-        writerepos =3D "printf '%s' > %s" % (repojson, layerinfo)
-        cmd =3D yield self.makeRemoteShellCommand(
-            command=3Dwriterepos)
-        yield self.runCommand(cmd)
-        return cmd.results()
+        self.s =3D self.generateSetupJson()
+        self.workdir =3D self.getProperty("builddir")
+        result =3D yield super().run()
+        return result
=20
=20
 @defer.inlineCallbacks
diff --git a/steps/writelayerinfo.py b/steps/writelayerinfo.py
index a0669bd..009e9fc 100644
--- a/steps/writelayerinfo.py
+++ b/steps/writelayerinfo.py
@@ -3,18 +3,17 @@
 #
=20
 from twisted.internet import defer
-from buildbot.process import buildstep
+from buildbot.plugins import steps
 import json
-import os
=20
 from yoctoabb import config
=20
=20
-class WriteLayerInfo(buildstep.ShellMixin, buildstep.BuildStep):
+class WriteLayerInfo(steps.StringDownload):
     name =3D "WriteLayerInfo"
=20
     def __init__(self, **kwargs):
-        buildstep.BuildStep.__init__(self, **kwargs)
+        super().__init__(s=3D"", workerdest=3D"layerinfo.json", **kwargs)
=20
     def generateLayerInfo(self):
         layerinfo =3D {}
@@ -34,14 +33,10 @@ class WriteLayerInfo(buildstep.ShellMixin, buildstep.Bu=
ildStep):
=20
     @defer.inlineCallbacks
     def run(self):
-        repojson =3D self.generateLayerInfo()
-        layerinfo =3D os.path.join(self.getProperty("builddir"),
-                                 "layerinfo.json")
-        writerepos =3D "printf '%s' > %s" % (repojson, layerinfo)
-        cmd =3D yield self.makeRemoteShellCommand(
-            command=3Dwriterepos)
-        yield self.runCommand(cmd)
-        return cmd.results()
+        self.s =3D self.generateLayerInfo()
+        self.workdir =3D self.getProperty("builddir")
+        result =3D yield super().run()
+        return result
=20
=20
 @defer.inlineCallbacks

