Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC459FED2D3
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14141.1773287566806275078
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UVnhsdyy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0n2877391;
	Thu, 12 Mar 2026 03:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=; b=
	UVnhsdyyhfwKaZZ1HQ1sn6ydMrJRi71u2NEUFyonKxEoVTvqLT0OzOvfAadKPtaJ
	hSok14vIiassHu432+VH8MjQ3dzrAdSf/ebjOdxYw4uH/0DHEkzdQxTdxalzsrDI
	PtbeNeENjRJ8za8RNq0ddsh6NTLC0Fju5t8gJG7/cP3VAqQ6nAvVNThSg2BO8i+H
	TLUicaLyNpwMSlkoq/fsxbSErCW2mFU5r6ArxJPBhgnrDxabSZvLmrd2Y8xpzWK8
	lxWAuYkTlp/gI0oRDyDtY0+Yv+rQqSFh7SBV9YjfbmqljP0I3qPNA1NKI8Hi6c+T
	sYTKyDuyWLIqIfoTb/e3Bg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-7
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEvqIqFmMasjIhrST1ScgDLleLYRMeY2wFgd3JnCwEhEN4qErQO1qLDbnPMY2mYe/d90Pm5/KCoAWT/yx3mcdbYOkRXmq91DW2p80oTgyAB6VdmBfMLXyjKoVGX87riajfFGK2ElQtS4qiwG99pFaAOoOzfgTsRPSLcOWA2HTlh3sJTkzDh3J2sTVRVuhlu92UsIxLsU7xd294jcLxC4duuNg8yaz2sb37upw4xaFdbbjSWsqDJxP+81w8ILYJpCzoTLNahnVdTTrx2WcaFJ4DfB6RptMLSp5KRLcG0WVE9OLgrTBW6W39GSiJ/MPHMxyPSZtCChhiNVbqw48sCbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=;
 b=XNYF+NG7HOWkCV5Hj9OzYuTrcVd5Zxr/oXXqRB9a6iunyGmKyt7tl+cy0ig+NwiLH1+xPZgaGdCgj7HpZumiBZT8t02/wxyQnqfGS43yv9Mm6hdrsXodhCsiVzmuzZCGrECrK51JefAUFpiiFU9ufo3qEmSB86NMPguKsHfGJT2SVbrXP9xE2HbjiMVnyaBlUekFawT/14VlQ0hFUWH+x8/ttK2LuNPLvafNs2CZNxPfd5JuOykY9WEEbXcE0S0+9JroqTRWjQsludWevb2t2PEKlzzKCR5DIsSlewVbPvZ/puHiBC8vcBb331QbdGrzx+IUXbwsP+BAhNW1LrlLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:40 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:40 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 08/11] upgrade-helper.conf: remove layer_machines from reference config file
Date: Thu, 12 Mar 2026 11:52:08 +0800
Message-Id: <20260312035211.745546-8-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: e7715148-332f-46b0-719c-08de7feacee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	8zmOjaXmF9x0mrgydueeqjtUoS9M7GmQE4lpJtDiSeighZl6lp3zT/uJcH7HDPoRPVHPBQcWNt3LUtYL9Jl+N2RzWXseI0F5Qf1SFVDfzJEvVrXFUud3+ZSSdrfM8slH6vRtPe7W48o5+TTMvqA+ynXk/lULzonR7sl7rPAj+EY1p1QsiPJNkQ7h1B8nSdsLnwtIj+j8OQXzPz9jnyzakyoOu5TUlrRYOvW5ZTva6F9KCa6IqHPi7u9s0W4Kxt9yMXDOhFVNWq3LgukH40PZqRdThI1DzSXkyOjsa8w/hgDHVRxk3Is2ryoCxM2j+NSbUQVLW0+xjzcMIzdtX1vzxf7KuegZr4fhFVhT1P2pW5DL4suhVvWoEivRHkTQoa/sCOq1M0w3ua086ElpgjtIxxp0v8fxyDXyeuh6csDsSmujcimIar+0PPC0r2bceexeYGmMi8oXs11ONcsKc8TP3lW4RappTQ6zIYkcTPagkmOvgF+kgmLvO3nHGQwovlgCxzmX4F36k5atczI8U7Y8sdXpnLFwi1vVPI9CCV3PCB3fbB8pVSFDE/LRxmYSDaK1MT65b2v+2eOvn2KBSia+mPLbxf0OgO/HSsl7PnCcHMfZzJrKJRTA71rxANiL6vILXAysVB08P5VS51GNipMMhe3hUsAgj+TosxEvxNowwtoCowiZzYUdG0SwzfGFCvJhkbRTBEx4Dm2P/uCoYOywLd5DbO6WcppS09hcPQnxzbhkoFP+YkEMbAdtxgWajTAdh6oYmuJPVGYSttK7IMUAqmGc4tiEvdsXFDJssrGOU4w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0NhgpFdDd+xaWKWeH+Eck8w4BSiAEi7fGbkRKoEqnmBskpgvgJAQvAT5XDa3?=
 =?us-ascii?Q?EqfNJvFLdYR0UvmYnkBz7ND88SvhOGb64L12waOg9L/Th315li6WFCczOxkQ?=
 =?us-ascii?Q?juVX4KFOJWSJ1h4yG5ykSjdI+ssGdQKHytZ7FgXUYyVmEpU0TQWpnRlRGbFn?=
 =?us-ascii?Q?og5yHLQsQ/FhZbtj/GqMImD3eCs4D2h7U1NkntuKqVeoUY3PwrxD1yeW5f3u?=
 =?us-ascii?Q?Eq0RWNpfwEV5noSjIcGxf9X7K0OI9H/sPOOUuwhTkRbUB+ZT4aRXpIRDs25W?=
 =?us-ascii?Q?nIFwYWfMux6sg7zVGpOohEENRaGiSAEmcffxItGkLiw+y/LOzZBmytriEWQ+?=
 =?us-ascii?Q?CSnwxd4cVqW8+MMwSM/P+19VjhCOmJmFyrcR24YVlImr4fu5UeJYcRE+BemW?=
 =?us-ascii?Q?D13GNicaoW1C61S1KB5QIZU/c+QYq4hwQZTeJ2bAHVesLdTKel1+711J1gOT?=
 =?us-ascii?Q?yLOpXLPWMJVhGjwHTg8MM4a0xEwftx/gRXASEy0LicxJKZSnG1XlFaR1p0gG?=
 =?us-ascii?Q?xrU3Y6KqPUSxsMm/cFDc/ZFvFkynXNfrLjui4qcfCO1Q4jV+aADCODxqOkq4?=
 =?us-ascii?Q?Ss/QQQmOOO7CFJg6li1+iGg2/snm4Vpjc2FBkMv7EVSs2Fs6NF+xFPoZPh0w?=
 =?us-ascii?Q?s+pdAgl2xJCnYbS6BfPDD/B2EusPblqA8BmjsHsa2K1Q7tpKeOxVuefNy45w?=
 =?us-ascii?Q?xYhN78pSyIhfYq8TvVsLTYTr6/XF1IH9jOxWozUUzaGogxkG5jliw5bqcWRX?=
 =?us-ascii?Q?gQbZbkUOwi1oy0z2E8G888Hv0x0GgD29KTka4tAQqpGsT/7cNq4dT83XuCIv?=
 =?us-ascii?Q?EinxIKWqSHSw6jp4qbchfXlIgs9jiJshi+peuuCk4BZfTsO1P2hFzaOaPMCo?=
 =?us-ascii?Q?rsY872FZ4SHJoDrcvn5DdktHL8E9NQEsBswp+LL2N9xFVewSrNO4tX335vXc?=
 =?us-ascii?Q?KREGa4yG2k2ZYzXlf/YXjH614JWLZvbKTDY8aM/FrlvSSTnii3kugbDVYpC7?=
 =?us-ascii?Q?HPKoTLIUJjW793qWs+0r4QuhXLedUxjv/+b6VfYnDm/y1b6e7lr4zaIsWJVl?=
 =?us-ascii?Q?kLDzEInEod0DOVhAKhZwDA5RKB4IPRrQZAenEQg+YO6I5qyfw2pncAO69xLX?=
 =?us-ascii?Q?QX+AEiV154vbXx5/N+Wln6HKxCD41CW92rdXbdRzXhapspyue3RCT+EAaMfU?=
 =?us-ascii?Q?CqEwEz/Fj1c2JFhy60zsiyzHOQTDJc60VeCZNxrl3+N5lfgb7yw7yTh56ms+?=
 =?us-ascii?Q?bPuTeGEcIJ53toNoVqpzoODzWjsbS7HFGxIopS3pkFU55qKfpRCQk/5aN51u?=
 =?us-ascii?Q?ulLG760VZkwjmUikA4jswujNDoejgunQIAuC0AT7CN7xgJsGiVaF+cTPXgVr?=
 =?us-ascii?Q?0TQ6SS3qe4owVSAxpSlYZ+RBfWBVScyn1Olt9r/0hahVn30Uwgzd5QksJSYr?=
 =?us-ascii?Q?wmeR7yi6By1W8GmFF0c2AoaZPGk7GuvaH/oVqtMdGLhGs+9F6kFF36G+mSBL?=
 =?us-ascii?Q?sl9Q9jXK+dLvGUvP1KfLO7bYeKdnc4tzUVDjEImAVI1maXbd9FxVaRPM6LCI?=
 =?us-ascii?Q?mBZh9T7xXx8KftNRulpJl6BRKLAPLxiYYySJF0ox3e4mC62grLBSSALAP1BK?=
 =?us-ascii?Q?MnX3qOnPQ44ptUYA/K5se+wAdu8Xab1O6PmrI7pVi+A8WYnKJ+0GYRafUHJt?=
 =?us-ascii?Q?z4WN4znpOrIRbCDoOv+rxK7QTQbwpgQH2PxLQoDoABMZi0Ev2D1phQWyF0P+?=
 =?us-ascii?Q?mZCO1RASfw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	W2Jwdspf2jLgJXuBdGq6CM6feDZTbUuAibDeNGT+lZtb5Sl9nSAaQAhV6bjeU5lyZaZmh7qfnMGZpor48iohoZ9/w0gCGJrx1EczRAbKpuSgShlYa33PTtb+pp9WwSdDZMZut0YUu+X3FyYwauPkCPH9WYr/ee7U/zGy7np3qGD1sV9aa/yX6aKPsaGLhEPujoB8IPMwZu02SyDONDYNrK/gTb4KQW+p2h7q/j20FbZDhTjBL+k9CuJOx/CEqcpCdkq3UOgJOkm3agFQoJSgthQMLNBFZf+tjS8gjFsDSN5pEC10meOegtXmsMStDk5W6UdI6vcsMrofYL2tYMkH0w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7715148-332f-46b0-719c-08de7feacee7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:40.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htdCOST2qYzqin8Dag4ON4VUmTGlSynpGjKQlvglfFgsUT8+DzkQLhDAutYCRfWFhUMGKI5WR0ASo6LkZpj0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388d cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=ieWZEeq6gUxmCoMFNBsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX5ARO5/UUeg/F
 gNeN2PcL2h44Zh5Tgh8tQFexiNXLh4H6qur6CRNt5QkUZtGzU1Pobrjwo2fDNivLzMDkkveO+c5
 r+387HBUQ+L5qhEWASjMLalkepjCZhwcOdh3n9laeXkFcgm0PjaZrfYfcclUeJT9MYdB344nE7l
 +52dtSoPWS/QyYUz6tfJfYAGWSUH1pnIVdtpjQDIQmryH1cn0dhzKPDkX24WS/eeyHgvpKdsr/x
 n6vH1YNhpjbRuDiXd5nu5Ox/+rSziDcCRAdN4QOwY/lks2qN0FJx656PjJefJCE6yRiMa2o7Ulf
 1eKqcP9yGKc7Qrqujs01e9JkcOWGWTKKypHRFyxTE8pZo8F9gsU9t976+rM9mP/YgtdR6OVbX4V
 OMsBmGzogzLn1H6RQdoHtV+M8ZfxyTzXbEa4P+WUJC9FG2P90TVqS1AUNCAKKLG9Q+p5tHUPWyE
 SR/rsQ0JcUo4ncMM2FA==
X-Proofpoint-ORIG-GUID: BJVqjM9aS90eu_aVP-tOVPP21Lpp5__0
X-Proofpoint-GUID: BJVqjM9aS90eu_aVP-tOVPP21Lpp5__0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3444

From: Chen Qi <Qi.Chen@windriver.com>

The layer_machines has been dropped by the following commit:
0ea93cb upgrade-helper: Drop layer_machines

Let's also remove it from the reference configuration file to
reflect the current status.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.conf | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 251c36a..269bde3 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -116,9 +116,8 @@
 # This can be used to upgrade recipes in a specific layer,
 # for example meta-intel, instead of upgrading oe-core recipes.
 #
-# When layer_mode is enabled, layer_name, layer_dir and layer_machines are
+# When layer_mode is enabled, layer_name, layer_dir are
 # mandatory. 'blacklist' setting does not apply when in layer_mode.
 #layer_mode=no
 #layer_name=meta-intel
 #layer_dir=DIR/meta-intel
-#layer_machines=intel-core2-32 intel-corei7-64 intel-quark
-- 
2.34.1


