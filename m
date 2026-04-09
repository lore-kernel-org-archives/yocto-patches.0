Return-Path: <stefan.prisacariu@prevas.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304AF31E53
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 15:57:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.133085.1775743837187178958
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 07:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=lsqbdvr1;
 spf=pass (domain: prevas.dk, ip: 52.101.72.2, mailfrom: stefan.prisacariu@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vwo5PyvsywaZ+uvVk6RgQlLv5b3YCmm3cYBieBn9QGgMLwK4XNOZHnJ9Q3Ne83yCsRAIo1pq3xySGbL1gGsu7eL6XAvIj9mtRQQMQ0yd1ixumh0O5HVxdRjYZVTPZ1d62DjUOZuVSY0s8rX64RKD9qG2HSlKi+4sNrm3YozAT1CVEvqn6Dqq+ajaWXkjTPnqAwZeG2Wv+UXm7BXzPZF4FNvlopU14GJ1go/hFZPC2RJ4H4PzEjJViF2f3EZZN3YwbdElHySGFkCVOi/ozGYddH3CvqKPREG9vHMEIa8GN83RQaNjoL4Sc7Kl1TzCJNE69rzB7F4EOzlM5Ef3jzhwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hQ8qN0YH4DbWlH+RYwPH+FYChcS1QUJpKznJ2Vn3OI=;
 b=QRtHbyhfQhRK94hjWlDr1jPmb0t+Wnp6zuUBTU3cUu9f5E7PsMMvjUV7YwJDcjIaR/Hl8GcRSRCVXKRcTwB34JWYj7hg5vEwIDlMVsLUYbjQ9Avig2+1ehzSQIp4CjSeoWZ7oFb9pweuWVQQAD4Pp1VPt6Xmz175UzBLztsiTqCoFtQLSj8x8te/2/TptcJTfxhRoSDDMfR5XNyDp3HOdntvHyRH/vh/+NEtWSbGrNNGbnyuunwR8b/UzMOd++u+K+6VsAxz0oGvxDpAuDCImeX8/V3DlWd/aXRF6TyWlVTlpF9vCC1kP7QpRuDRcbEe2jEvdepDIGSMbY/mcWTEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hQ8qN0YH4DbWlH+RYwPH+FYChcS1QUJpKznJ2Vn3OI=;
 b=lsqbdvr1708sRoqlMZRiS9QdiuUmgyeuscaRkIKNuy9TVt/2RIY520dAiddFoBrSUQRnhBD2UaoSltZVG2UsvCd4aqCnx1cYuUxGY9GEtKFDUaMuFcombfFP6O9CwtAZoz5m3yehpV/Jw1XoCQAVS8UkpB3Ul6VRW1/kTxlVkvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::14)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 14:10:35 +0000
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87]) by GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 14:10:35 +0000
To: yocto-patches@lists.yoctoproject.org
CC: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Armin Kuster <akuster808@gmail.com>,
	Stefan Prisacariu <stefan.prisacariu@prevas.dk>
Subject: [meta-security][PATCH 1/2] python3-tpm2-pytss: update from 2.1.0 to 2.3.0
Date: Thu,  9 Apr 2026 16:10:08 +0200
Message-ID: <ba9407e41d55aa475eb94b6f676cd13fa1eb5b25.1775741022.git.stefan.prisacariu@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775741022.git.stefan.prisacariu@prevas.dk>
References: <cover.1775741022.git.stefan.prisacariu@prevas.dk>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
From: <stefan.prisacariu@prevas.dk>
X-ClientProxiedBy: GV3PEPF0001DBB2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e9) To GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:326::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB9484:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: aa757887-3342-4f7b-b21d-08de9641c51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	3KcVtGlEvzaCzmHCZZM7RyEvHafIRJq0RJ2MeshBESIaJAjnRcwxLKMaI7SO375gMz8fohGSd03DOizquzLaVeZaO8s/uRPFnJpEnxmBvkTTun4hlPR2nGivJnf7p1Znwc3BbMPOz9DiCadCZyU1XvfgLI3c2AAtNurhgkrtVhUuN6UOhUiNHQffY/RK8H5v5WXjF7weZPgtNKDXveE+9I4wimmZAtFnjKeNU+/vKobt+wYCo3fMHgs0fHw1jbhkSgR+eC8LhbeIAjluZjvb1pXhjrYtBROiJXfn212IWPW3LGp6EpDq4WaKH3vjmRLTeULlOxuehfLDgV+IfO5nXc2uNglNmSJa79RP2hYT1wRGV8816hNdB+Wt/4ufON1a2K18iydAVMxIyU9TPCNzNYzEeamXQ+OeqXhVIqMp2kk0WprSQFXrQ7hQIm9Gw5y5N8D3Tcl1SWbIUSDgaFBF7rWE+qLiZLzrbnQ8k/X3ejSIuNOA3b9e7+p75ggHRT/hXq1lY5QmdUNVtRxpBDaVmOIIfSGu48/P4diabUflIHfKDsjhBnN+aWbxcWajlAOljoPZfu9BQU126Cef9/bbVr0pbouSmsF+cxbOpxOph4f91bcNXE58xTxmFwgrlSzH88mdHnY3eU1aB29+sbgo0Fyhh6Od/OOCjbNd8Vz61PUwsoSZjbhzv2Lo3uvNCpNbbB4NG9UTXyEqLiFTxCIJiN9dNNzdbIdDQJgnsX1IYZgTSsFvX17LdRjMB1tHsf4Bo8XZomS3gTuwIaFQwglPIPezZiDxTyx79UHS+hPYKxI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qF9A3GZZ9cd5k1vHmGN0LV9uvrprOurmJ5FDOl0SuVbgfw8pi0cZDXsDqjt4?=
 =?us-ascii?Q?TZdX5tXFkSGTM9NchVhamKL2lXjums6K75CiCfemT5+M/cx86QHS0Mxsbext?=
 =?us-ascii?Q?ooZEo01WGzLPzb0NjMpwLtTXTpPgU1BSPc/IThH8CnHi9sf8zZ1Z4wvnpkH7?=
 =?us-ascii?Q?fh9Eq2EJfrbZ58DbihgINr0bJPnRIDq3Ttv0RQCuwmwNt33z8xhUHsrrjZTQ?=
 =?us-ascii?Q?bK+zft4wfgrDSDuBtvHlxj/WlQRbCkjbOxJwRTeLTtCLiF9SxB+5j1K9NG5w?=
 =?us-ascii?Q?CmTybmZP6hW7ftDxGx6za3GgvxTJf9/J389eywK2UpqG+S6GVoWd0nNDT/LC?=
 =?us-ascii?Q?KjwNhKVwJMITcTyf3ZBmzuQet/Hg1TYEflNdmOQyn0bOK60cNKw9syiKm2uz?=
 =?us-ascii?Q?+rHG3luak0G8v8W5HcrTJ9xcs8A0RF/hWNmpcXOx400ryw2b/uyBFpvYzHDU?=
 =?us-ascii?Q?eQaMJ7LobbqgrLc0o0NbCVo2u7bVSAC5rJyV8ZhRgirRi8XGrgoPlnq2pN4C?=
 =?us-ascii?Q?Dyx39rb6N8c/A34W2fsg6mzh1h/ABkSc2LKIziAVOrpBpNd7kkQ8QDFbndAC?=
 =?us-ascii?Q?uk26WxdkY0OrrAIkNUCayroI7Y+EwC6N63hUAKdmtCXyQ5B84sZ9EjDJQPNm?=
 =?us-ascii?Q?VpUFsltoRM/deOfePNgPZE5uWEc5MNLgzzXJ7o+FB1iH0jFgRsccyjiG+h+n?=
 =?us-ascii?Q?PWzrair59cB1rT/oAgsWttkdPXkeukx+sJadUVUXiNf1gA0NNcgUHpoy+nnn?=
 =?us-ascii?Q?M23HgHRb8Ss9eeyoejGmM9srLAS0aJ0HGLH7qDh7UlLeJt9bn28znGfr/GnX?=
 =?us-ascii?Q?8gR8nGF0DC5PfTxyq88JBhJ7f0nsMW5CFYRpG8mfJII7eqrKbcCU2jrG6rug?=
 =?us-ascii?Q?tjauozQw7ujAN3ARnkbaSkwjw/civk6pD+oPfbgpUvTSCXxj9grKOoqm2evB?=
 =?us-ascii?Q?H2ISap7vGoWIEl3RSqxgc9Y8gJJ5mMwe3+b8UefL1FCipODOgqoLM+t+Amtc?=
 =?us-ascii?Q?1YeCsqrpQ/xs+nbb3GCLwue2GjOFhAxS2h8vsnCJnOUYd61YJfVmt+whxMAX?=
 =?us-ascii?Q?0w0FYW4p6S+FRqHKDGmk8VXd88jcQhuEWZFR+b589eBA3PHUaM/HWAlXf0Jg?=
 =?us-ascii?Q?IwdcmeNbQfKUZ4ABPkTL1+eWTue99khn/Pk8ioyF/II66bc8U9g+GjGwCngy?=
 =?us-ascii?Q?JYgCzNuNJNmP4erDIJcWrATDkf2xdQt7iir/wSn7ShXV7sVZxHeCHqL36Q/C?=
 =?us-ascii?Q?99YmkFVNqZGDrCj08oSI35TfXwu8MUPS3n7fG+FZjFE2XY6oiKPbBe7pgzLP?=
 =?us-ascii?Q?BBai27tLoFnNZd9DP/q6cPJSbNYaf668qOwyebAzycR6a+kPyL2rFinOlP4q?=
 =?us-ascii?Q?uiwnyPkONYbDbVjUv02NHSINC1PFnNs2+ncf7I49+pmzOg6WYEUt4DTitACm?=
 =?us-ascii?Q?FyV0fUFTSzY0f9M34FmW6BoespTmcB/T+iwETxTz/xSQZjWBr1e8w7T6ALAZ?=
 =?us-ascii?Q?VCPyorLc1GCuSv72S0oIyAsexwCVH+xsQ0BdkaZ8pvH1QH9AmPS5JCUb/SuJ?=
 =?us-ascii?Q?riA1jY9eKq46ShY1aeJIu+ckWGJ2Ij7wD0uihkey/EicRIxNnVpI4T+xLU9l?=
 =?us-ascii?Q?/cbbWDnb2pcjfxSbeVBJhwTsIYJIV/60Z+53oTfkWl9+ugre3qwhcGzf8Ubh?=
 =?us-ascii?Q?rNbhVNlMcJrTqCiyhAfIOPsTIV7p1pCjgz5sCOr0Ql/DiZ0zL0/67HrwUj0V?=
 =?us-ascii?Q?ATtzrXJSCmrt9VQHcVNjk5nCjhnhA9o=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: aa757887-3342-4f7b-b21d-08de9641c51c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:10:35.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrzeWe5RovmcvFULZfHZk3yL2JxJOICG8NspbCG/6Vrg8SPklTKRc2FzoKfd8AUE9MGOgkJwUmDzjmFlI/TAmZ7Dyg1qSTzlcBpel8ty7lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 15:57:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3681

From: Mikko Rapeli <mikko.rapeli@linaro.org>

Upstream changlog shows that python 3.12 support
was added/fixed in version 2.2.0:

https://github.com/tpm2-software/tpm2-pytss/blob/master/CHANGELOG.md

To fix build error:

| DEBUG: Executing python function autotools_aclocals
| DEBUG: SITE files ['endian-little', 'bit-64', 'arm-common', 'arm-64', 'co=
mmon-linux', 'common-glibc', 'aarch64-linux', 'common']
| DEBUG: Python function autotools_aclocals finished
| DEBUG: Executing shell function do_compile
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packa=
ges/setuptools/__init__.py:80: _DeprecatedInstaller: setuptools.installer a=
nd fetch_build_eggs are deprecated.
| !!
|
|         *****************************************************************=
***************
|         Requirements should be satisfied by a PEP 517 installer.
|         If you are using pip, you can try `pip install --use-pep517`.
|         *****************************************************************=
***************
|
| !!
|   dist.fetch_build_eggs(dist.setup_requires)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:27: Syn=
taxWarning: invalid escape sequence '\('
|   s =3D re.sub("#define TSS2_RC_LAYER\(level\).*", "", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:28: Syn=
taxWarning: invalid escape sequence '\('
|   s =3D re.sub("(#define.*)TSS2_RC_LAYER\(0xff\)", "\g<1>0xff0000", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:28: Syn=
taxWarning: invalid escape sequence '\g'
|   s =3D re.sub("(#define.*)TSS2_RC_LAYER\(0xff\)", "\g<1>0xff0000", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:31: Syn=
taxWarning: invalid escape sequence '\*'
|   s =3D re.sub("/\*.*?\*/", "", s, flags=3Dre.MULTILINE)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:34: Syn=
taxWarning: invalid escape sequence '\('
|   s =3D re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\) \(.*?\)\)", "\g<1>..."=
, s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:34: Syn=
taxWarning: invalid escape sequence '\g'
|   s =3D re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\) \(.*?\)\)", "\g<1>..."=
, s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:35: Syn=
taxWarning: invalid escape sequence '\('
|   s =3D re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\).*?\) ", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:35: Syn=
taxWarning: invalid escape sequence '\g'
|   s =3D re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\).*?\) ", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:37: Syn=
taxWarning: invalid escape sequence '\)'
|   "(#define [A-Za-z0-9_]+) .*\n.*?.*\)\)", "\g<1>...", s, flags=3Dre.MULT=
ILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:37: Syn=
taxWarning: invalid escape sequence '\g'
|   "(#define [A-Za-z0-9_]+) .*\n.*?.*\)\)", "\g<1>...", s, flags=3Dre.MULT=
ILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:39: Syn=
taxWarning: invalid escape sequence '\g'
|   s =3D re.sub("(#define [A-Za-z0-9_]+) .*", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:42: Syn=
taxWarning: invalid escape sequence '\['
|   s =3D re.sub("\[.+?\]", "[...]", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:77: Syn=
taxWarning: invalid escape sequence '\)'
|   "#define TPM2_MAX_TAGGED_POLICIES.*\n.*TPMS_TAGGED_POLICY\)\)",
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:262: Sy=
ntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Marshal\(.+?\);", s, re.DOTALL | re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:266: Sy=
ntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Marshal\(.+?\);", "", s, 1, re.DOTALL | re.MULT=
ILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:270: Sy=
ntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Unmarshal\(.+?\);", s, re.DOTALL | re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/p=
ython3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:274: Sy=
ntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Unmarshal\(.+?\);",
| adding path: /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa5=
7-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts
| Traceback (most recent call last):
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/setup.py", line 280, in <m=
odule>
|     setup(
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/__init__.py", line 103, in setup
|     return distutils.core.setup(**attrs)
|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/_distutils/core.py", line 146, in setup
|     _setup_distribution =3D dist =3D klass(attrs)
|                                  ^^^^^^^^^^^^
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/dist.py", line 307, in __init__
|     _Distribution.__init__(self, dist_attrs)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/_distutils/dist.py", line 286, in __init__
|     self.finalize_options()
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/dist.py", line 659, in finalize_options
|     ep(self)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/setuptools/dist.py", line 679, in _finalize_setup_keywords
|     ep.load()(self, ep.name, value)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/setuptools_ext.py", line 216, in cffi_modules
|     add_cffi_module(dist, cffi_module)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/setuptools_ext.py", line 49, in add_cffi_module
|     execfile(build_file_name, mod_vars)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/setuptools_ext.py", line 25, in execfile
|     exec(code, glob, glob)
|   File "scripts/libtss2_build.py", line 69, in <module>
|     ffibuilder.cdef(open("libesys.h").read())
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/api.py", line 112, in cdef
|     self._cdef(csource, override=3Doverride, packed=3Dpacked, pack=3Dpack=
)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/api.py", line 126, in _cdef
|     self._parser.parse(csource, override=3Doverride, **options)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/cparser.py", line 389, in parse
|     self._internal_parse(csource)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/cparser.py", line 396, in _internal_parse
|     self._process_macros(macros)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs=
-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/si=
te-packages/cffi/cparser.py", line 479, in _process_macros
|     raise CDefError(
| cffi.CDefError: only supports one of the following syntax:
|   #define TPM2_HR_PCR ...     (literally dot-dot-dot)
|   #define TPM2_HR_PCR NUMBER  (with NUMBER an integer constant, decimal/h=
ex/octal)
| got:
|   #define TPM2_HR_PCR ...<< TPM2_HR_SHIFT)
| ERROR: 'python3 setup.py build ' execution failed.
| WARNING: /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-tr=
s-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604:190 exit 1 fro=
m 'exit 1'
| WARNING: Backtrace (BB generated script):
| 	#1: bbfatal_log, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cor=
texa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line=
 190
| 	#2: setuptools3_legacy_do_compile, /home/builder/src/base/build/tmp_trs-=
qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_com=
pile.2430604, line 180
| 	#3: do_compile, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cort=
exa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line =
162
| 	#4: main, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-=
trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line 194
NOTE: recipe python3-tpm2-pytss-2.1.0-r0: task do_compile: Failed
ERROR: Task (/home/builder/src/base/build/../meta-security/meta-tpm/recipes=
-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb:do_compile) failed with exit c=
ode '1'

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit 8d50defcdf534672184ba6e9296a8b668e99f214)
Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
---
 ...pytss_2.1.0.bb =3D> python3-tpm2-pytss_2.3.0.bb} | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.1.0.bb =3D> =
python3-tpm2-pytss_2.3.0.bb} (57%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb b=
/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
similarity index 57%
rename from meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb
rename to meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index c98d4ab..ae7dcfa 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -3,13 +3,18 @@ HOMEPAGE =3D "https://github.com/tpm2-software/tpm2-pytss=
"
 LICENSE =3D "BSD-2-Clause"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D500b2e742befc3da00684d8a1d5fd9d=
a"
=20
-SRC_URI[sha256sum] =3D "5b5b4b1456fdc1aeef3d2c3970beaa078c8f7f2648c97a69bc=
f60c5a2f95c897"
-
 PYPI_PACKAGE =3D "tpm2-pytss"
=20
-DEPENDS =3D "python3-pkgconfig-native python3-pycparser-native python3-asn=
1crypto-native"
-DEPENDS:append =3D " python3-cryptography-native tpm2-tss"=20
+SRC_URI[sha256sum] =3D "20071129379656f5f3c3bc16d364612672b147d81191fb4eb9=
f9ff9fbee48410"
+
+inherit autotools pkgconfig pypi setuptools3
=20
-inherit autotools pkgconfig pypi setuptools3_legacy
+DEPENDS =3D " \
+    python3-asn1crypto-native \
+    python3-cryptography-native \
+    python3-pkgconfig-native \
+    python3-pycparser-native \
+    tpm2-tss \
+"
=20
 RDEPENDS:${PN} =3D "libtss2"
--=20
2.39.5


