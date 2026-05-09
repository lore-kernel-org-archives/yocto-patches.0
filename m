Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E5CD3447
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 04:56:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6443.1778302576599463122
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 21:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=WFy7Jlb0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95892e51f6=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494j1iG2286268
	for <yocto-patches@lists.yoctoproject.org>; Sat, 9 May 2026 04:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=z+L9Bbk5os6gnMZeAspniAhGTf1OHuWHMQNKKBtko7I=; b=WFy7Jlb0xa+o
	TdOJxtlG6VZpAple3wg7d0X+8qHaVqY9D3XtxLwL1TNewHjkFCPEj4KTd9f173HX
	gJLRLd3eTGa8owg/Os2ELJu0Sw192WeibJ1Uoykla3h783dEl/5nQ+UvuJGJE6RN
	oY/mlvUjqq7TzNP7pC+DMHR2BPFxp6c1I3PCnos83CsvNNCio95VNH0zSFDIu3Ja
	rL2a/k7KxxrB8VV56O+3HtCt823l4MGYtaKhoJ+W1VUKMt6VHLKiW0ADCu2VSRR6
	oiLmmRewJHX+SWvy3IcwMN2FegjXxFqoolNqQy2gG5aqHCtsiGbwwTtxMHVx2Imx
	HUGiLbKneg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3b6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 04:56:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js5viFJ35TjSFs33Qt69VZ3Z1k4Ykc5YzSk1ruB0N3FGncUwGFS4c0QmeU96p6013P18vYq99Ttq5cgTstbJkHQgc01JPGxZexRY8MzIJOaamwF6rX+VLieydgLGnJ2oqBiGSPuS6S/w2DRXnkH0scsU1RM33B5wDVmE8SkaMNlOLy283aJBxhEsmVTwlUKbQ2t77O24GY+4xtuSSRTd6uhLLohwX48TphAjn/LEixOJgz/OXGhSSLHdo0ywSu7Pv5MYdp8SE6PJuYFUaKMomm2osXPQLpW9puW3RplDed0m0x2lz02Pne9qNcegOQMOwZvo1o50gylPlrzc5qnomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+L9Bbk5os6gnMZeAspniAhGTf1OHuWHMQNKKBtko7I=;
 b=agKTNS33WUUEb6wq4MplkqqxXxBzC1R44ygerNF/NgUxN/wU/auQlbkVIkLdO5fDErrYpgkNsVT2jb/0TAZwW7uPe+8SFTg1YEHMJ5RbgeEaxyjfcbCe7D66m7tOtPHhIyom/KV9YWGSoxGAMjRkE7ZGU90zLCOeUeeLv6+TI0CoDJ4K95K5v1+ht9S8PVsS+ZrLUzBSnnHiABZWtP3Qm9wiNQVs8uiSz/7sHZwhB+6XYb8Xv807tFJKdRLSODi7h3LNzdXQLGNohSJpUfnyPlbHqQXQ6JvKxF9NazfC6xuhPwhkxiVpf6gW1tfUPFszmUUO+RMlKOrGdxTn8QrSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by PH0PR11MB4903.namprd11.prod.outlook.com
 (2603:10b6:510:36::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 04:56:08 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 04:56:08 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [v2][meta-selinux][wrynose][PATCH 2/2] libselinux-python: remove all RECORD files
Date: Fri,  8 May 2026 21:56:01 -0700
Message-ID: <20260509045601.212844-2-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260509045601.212844-1-zhixiong.chi@windriver.com>
References: <20260509045601.212844-1-zhixiong.chi@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 61835f7a-6960-4148-e981-08dead874821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|22082099003|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info: 
	hOh+1e80sovIreFzAMiRJN3f4I6mLpHwlMt1Nhc7lCi2Dmn3WHg9U+D1EwjJ78E096caruwFjE3boTZhibKzomRQTmRb8i/4BmtCMGx/z+e9lHHoL1s+nBTuUlIP58KYa4TWw7TWfdH+aKKRSShm+GWfoVkfrYXe+oAFbWDFDFIv/zP2bIZMdA9l1DzmP7BCaLdSVlrWyzH6C75S1rSDCP2y46oQUEvyr5sYHtilE2YW1Iv8K0e22XEDvRdaT6D5Xxw817XRzT5+E3wRwGVPK4lBObbAgl6BgNFSX4WueDkkbTEpG5B4A9cSfbchRVkl3rsWuPKG1lxGv909LBtuudF9RAaAawRlh4UQdI7Q2rYRCXDYKImRJyLR2LS5dMzcZgWDizsMCmqtKdJznv0O1F7xbyao7stCyXzyAr4762p7vPOgmmK2T5uy7X1TBhxyU8C6d98pwo5TSrUlwKkutVnG1WVQz67k7YRH3Pelksl4dSRN1FJdLiVEKP+fYVMao3vzLJXugfCX07uSOjUmTP/KCM1l0IGSWugxpF39eh2RmwIkZaKwxx+9Bsn6LIK0YNke9t9d/IAhEuwNn7Kid6mYUCmblLbGSlcYSIV0I1lFTav4IuiYr4pdhl5XakwchlQcNNcRY8ySlex8gecmvNIm837UzlgxzigH3aa6QqOcBTXvc7pYb/A6Qouf5VRl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d39KM7vDuhWVN+eTX8PO5cR4XPSD3hDlE0AAvYThUYD+ehJ+Hp+JCNCW95SM?=
 =?us-ascii?Q?lrPWyCe1l+BkT8xkAAvVPUMaa98QzaXistwo8uNEizkCsuaGGxA5BkTRKdmw?=
 =?us-ascii?Q?orEpdyzNjjWMMVDFn7Am57jrMRK2NLfr56iojMx2PGrw4BusnsrKMkiXFvf9?=
 =?us-ascii?Q?La7KrIQHjY73XFkd/23BPMOcDXk/UAsoxhdiIaz2edVy7BY922ESzve47smN?=
 =?us-ascii?Q?VeKd0BPkCyAM+mDKuryRBUYQGL1jBMLlHCm4ITki8z7yOgl0zSs2NfEo/AWX?=
 =?us-ascii?Q?4TGKevJBwBnTarXZPBIEl2GBOd3oqRkYRznJgw3br5kBWUGq49llxAw/Uybb?=
 =?us-ascii?Q?rEZT1EinISrxMFAb0yIII4Y1v2ciw49ZCqsErG44gG6g0h67/u4T9N7MHyca?=
 =?us-ascii?Q?sQT9gS020U0anbxRYS1qdX03H3Jl/k+NHvEGqOSvTEmn97uuRjx/TSIWcTW5?=
 =?us-ascii?Q?jFTTeA9DUQa3hGwtT2EfE3Ip24jpU/pyLOu9Eb2Nv26/QzytEpbE+QpwlL8v?=
 =?us-ascii?Q?E44z2NkR9wJZPIlkz4YgtYuVm6R4mgJLDN7fsfaen2SaiTHlRFyzKQVUHUAg?=
 =?us-ascii?Q?IjJHKOqmZBYviRuXnmPpPZEmO99IXsmuK8P8GqFdiKbZY2/26MCGM3kIg1fA?=
 =?us-ascii?Q?Qkpg5LicAD/NAvo2R34UHgSacARGrJzg0M/L+cdHtRN/W1R0Nq4RcQ0fkNyG?=
 =?us-ascii?Q?Z70XnAGPrubhPUuBdnqntkEzGxKxxFCtKHb3fPhEZnppx2lSuWzhC4/vjYRT?=
 =?us-ascii?Q?YiE6KhobbLP42noCx84okxhNq+hkKeszdqwoMKyZkyL6o4bBr1wDu5HeMkXS?=
 =?us-ascii?Q?Dl5CaFspKoUqE6DvROuD1BE+SI9ydxg3udWRf5unuQ6T8e7A7SmqMynZF3uS?=
 =?us-ascii?Q?+odR75yisqzy1JdIWw3QksVXWoUNxDiRZs+jNta3q01oV4eH2Xt/IRy5RzXS?=
 =?us-ascii?Q?/Dtzce87DM54FyC+CYZ2Gp27PjgFNkofL9PULD8y8vDRzwHrjXkaIi3LnfM6?=
 =?us-ascii?Q?GY0651iw2Y3XsnAiCSaKeSj3HwHJNXe0biLmcpJAJk2ay0W7ZTQy0Ab+1CiR?=
 =?us-ascii?Q?QSdz4/SZVxHlqUfTakVyQgz6PeuXgBxxzOuU0xtvAxMboa9DIt6p7U7EyxqU?=
 =?us-ascii?Q?wbMNso/X8k5t8BDLd27w2VSRKfLKN46FRX/E8+JBHEP5qOQs+WJG8gWWuQ0U?=
 =?us-ascii?Q?7wZHOg7+L4IGA+ZjPJORJfA6CL4sgvRwuLRcuaB20btC06vI+cXcsuuqWvbA?=
 =?us-ascii?Q?bnLPS7pcBR1UDvYIzwkcu2TiTxn5D2D+TO885r6JcGgsm0Fx+H2Sx8VWseZG?=
 =?us-ascii?Q?ZaU2CRgbJ1j8BAmBvkmAxYoQPxQrN8M254xzn1d2xzeh+tVRjB3Vh5+zxqgh?=
 =?us-ascii?Q?9HhUNgadr39Ui6yIQwikH63+FmLiFtjazDNOvSQKRqds9MK7BsuMjluO+2B8?=
 =?us-ascii?Q?bKbDE0WqDuM3HkkQVtOXXcGPG3flWdek57Bzx7hwnb8Cpy65GsZ0VHs1fLrq?=
 =?us-ascii?Q?U8ZvZzu5hsd5J1FI8f4NrWvT/3OnCC2226l2lA36gG3h/RGPOtrSSCCOfX1t?=
 =?us-ascii?Q?rKisI4cwmJHQ4VPnncxgOSHD5WFQSX8Q2kNO3WBknoXvplJUAq2YYy6TnKqv?=
 =?us-ascii?Q?onvxzLJnB/CHamDAYdWENrb2Vp8rvPe15f9x/VMS662AmGlf6OV5tnXBppya?=
 =?us-ascii?Q?1I2/aiwdaqIvRIIHxBBdT0Rvhy7PTy1k3/f7fiHBu3otZW4ZBXTYsx5/s/7t?=
 =?us-ascii?Q?GHnruuk2J/Fzx/2EyNzgb+iPLKH2T5g=3D?=
X-Exchange-RoutingPolicyChecked: 
	nRJMhaveZxo3fh3wUVVtcsyDmyy7H6bZ+5BKMWdBpR0EFNRF4CzInWQqwMePpLrsBHTAb7yyM+Rwo3oEJPqy65bEweuboyqJiJxk9NVFYAfi1tb53KRjC1ECf6o2WlMRK7LYFMEisjX9yuMVnxBx+jaAZ8pueofoW/JxNAPBpQqyZ1xKN0lX6VbjCeOfSQsnL/96U5rABIqLNkHYmSJalfWKaVUE85CqxHvAzLWCIw9pStt0BMP9S7GRTTAVVkVbhZN8Ht1ZHI3p6ad6A5d+P49C+WGGEbwUX+qb2WYexAcR/QX3qG+JpmKL4XeGhKcgcV9dQdiAPFimZ+ZAHMS9Kg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61835f7a-6960-4148-e981-08dead874821
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 04:56:07.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK09V+uSYnonJKAzXd547Wi6mXczaUQ6IZMF0Hl2Hv3oA2J0GDB7LV1oWsn+EhBLC6PbROBEO1JICTOPvyZRAYZJ80EqgKra2o1eKh96U2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA0NyBTYWx0ZWRfX4TXX9a2C2ieN
 Onq5IJmRf9uKb6KsL2UdNo07UYPeonLc0LHqXoNz9EjMu1IHW7A2TcZ1ym+Nt6NTIsy6R20NLKT
 aQlQ/FLLZ3nLeEtmHzMgtzxTwnZXSN9P7m8W6HarN8keN6lHPq/IRdRdJSWf1H6jKh2mTYMd3Ec
 +EBDiViJY2yKq0XnpZA6Uh5bWnIWCBRHiPOhSF1JKir0zKoWxHJsqGwGou1+FJ81PNK03EHHXfU
 uzfKMDaroF2k/ozy9QoaaeTIXPTn+VIbvqr+2BnTxjYtsxBjl6PVENEEluB4/IH7gnPaKIC/PJK
 +wtNRYtCWJha2fzsopGzd1GdTtzQNVv340xSR/Bv73j6lqRyviLCvgBmUyZ5mrf5izuy0wLMsA8
 2SaULRF6L/BB5eL5FsplPoeKLiq/MQ==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69febe6f cx=c_pps
 a=Q+OuU4uwq9JOSoz6MpkFfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=SsMK-6ewAAAA:8
 a=t7CeM3EgAAAA:8 a=o8dCtG0ciBTDBm6uPjcA:9 a=49hUO6naoDravHwzbBTq:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: pUabDpUVnH44J7jbV2uli4tcYgYfHW6U
X-Proofpoint-ORIG-GUID: pUabDpUVnH44J7jbV2uli4tcYgYfHW6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090047
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 04:56:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3955

In order to support reproducible builds[1], we delete the RECORD
file for selinux-python recipe, please refer the details in the
patch comments for the selinux-python recipes.
Here we do the same behavior to keep the solution consistency.

[1] https://reproducible-builds.org/

Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
---
 recipes-security/selinux/libselinux-python_3.10.bb | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.10.bb
index 98296e1..139e6df 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.10.bb
@@ -53,18 +53,11 @@ do_install() {
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
     direct_url_json="${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json"
-    oldhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
-
     # Fix buildpaths issue
-    sed -i -e 's,${WORKDIR},,g' \
-        $direct_url_json
-
-    newhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
-
-    # Update hash of direct_url.json in RECORD after build path was removed
-    sed -i -e "s/$oldhash/$newhash/g" \
-        ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/RECORD
+    sed -i -e 's,${WORKDIR},,g' $direct_url_json
 
+    # Remove RECORD file
+    find ${D} -path *.dist-info/RECORD -delete
 }
 
 BBCLASSEXTEND += "native"
-- 
2.49.0


