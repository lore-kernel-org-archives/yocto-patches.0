Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3419AC982FA
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 07:31:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4759.1790062283199466539
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 00:31:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=lNiQ1DnE;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=NlsTiovW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7LBdc3186119
	for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 07:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MmkX/7SB9qr8ishtYXj3XdUfPzm/+vV+dGyvM+zIUe4=; b=lNiQ1DnEnRHXX1rS
	V+HvuVL8fH+fssKFQWE+6wZse/SyPor6vGTtAJ7LR2Bf4gsH58Y3mV3UwbuwkRTY
	0xCYN/lQGBDwxAy148JI8H1QAHxppYJyyU7IGJa+bOz4cdQgkVugrqeoB1ZE+d5X
	C4Yu+RmTISuSHt+IH529/TopAY9hnBRBwTA3bJpXy/hE/gOZ9yzq9hf7ZWpJa6Bi
	rZUpCyQImmIql9/oSOlYmoQsLkkKHx1JKSBS6XRpdZRTyqpfi1q+eYernJ3Le3Ho
	cXkP+PkD4eFKeXpiaDnjghIyNQo3ncfsdGpcbw3axk9crTAv58+W0YAFUg+BegGp
	EofTJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gueybhduw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 07:31:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93903622880so121517585a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 00:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790062274; cv=none;
        d=google.com; s=arc-20260327;
        b=Q9S/0p7P7pbXNqWCI0u1hWleqUXjwy6s0kQ+1VvsoCj4yDjSTc+sW+FYYosRkXE0ND
         fbGwXWkSPd732F2TGkIrYWPBmT3/ugQlUI257RKc+yq9CgQuga0dS2HxRepxc+MVdSsf
         McK+yxqeOCDIuy8f0DywbW0Q0Vwf/I149NXwklj7jjfZ9+hj3kO4GvZLFkx0e/GLTJtj
         thB5EbxW+UakvOFNnWG+f0kRdaBrJAJudAulErqz8YXDO7H0kcE/P6fGZ+rycDiNDafu
         NPCT9PjX0QU9fvFnI86T7/f2drxvu66rFzlU1+Bp43kVYgMU75noXONj5w7Yv3uFB4mm
         AHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MmkX/7SB9qr8ishtYXj3XdUfPzm/+vV+dGyvM+zIUe4=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=Fw7CjYnlUkNoCazMhmQcHKfhnYfxxQ+WLXK80I2QfY5CqtY44SFkWOWwdyW/xkV0A5
         Cf1gaplYvWxZhGfKdneaxFn+aGle26SouUse0baW7CGr5zAfoMRclzRmypobszSmV+m0
         NA74ng/ZmHqztUcLFHfulZp18vyauHhE2A2wQ+BwjebBh43jknC5LDFEt8gt/jV6Jmxq
         PAK543DAncVSZ73+Nl3DlDgFSUdFVGNss+e1fjLDnygmTRQMbKd6YyLTbB76HpA768Ra
         AD2wzg4bqt20H87ap/t+bOAwh9AtU2hfORxiKYJafsbtkeJKYSRL2dvJ9kX/edVT9/C0
         I2WA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790062274; x=1790667074; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmkX/7SB9qr8ishtYXj3XdUfPzm/+vV+dGyvM+zIUe4=;
        b=NlsTiovWAyc694j2U55lNEffRUmfI1M2g4bngYxB84/M9Z3iNEeO3ZNAkzO7qx1Gay
         r7oGNYH34a+BgepTEfibqIPHvM5ih14Lrm16fTW2KE56vSsX7tL4c//YLPHvhNbWX8A0
         XFfuZAYdabnqVKAYg7+1LhePQz9AC695kAvlg8ehVYNuvQkNhQvyMVNPylW5Prf92JTb
         Pv0QUgC6cOCgjsxPuHosjuECWViS6rBphH4aflnGeMbCJes/8qbxXAQGxa2wuPOCbv4z
         CgQSr4D8K7bPodDVQZ2Uk+F5y13XqXLLZsMlWIpyuuDioB2SW6WdfZ5wdZW9poRDBb99
         88/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062274; x=1790667074;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmkX/7SB9qr8ishtYXj3XdUfPzm/+vV+dGyvM+zIUe4=;
        b=EmPHFOVzsheHLOixkcpYMq/RPGr25zFAfLdKVnzpzW8jjEmp7duY7nlHBd/spFF94t
         7IKj/GNSviRF/8YmM+CUTesQPgn4w4lNmqB5HhFOe3rXf7KYlJjA4nW/HebmpOWVJ7cO
         pUhXTBbvwDAGdSkt2hgAiH/XQohhi0CX63mkrgnXXfyBOIfNKIRE9jxm5PKmlud7GEXF
         G+nfLaZJXtcCAo3Qef2ZWnXYdUSd64IG77flSqKTCmFGkPOHTQby8nOnF2grYI3GivCu
         frOBtLpjGsTfOWJ1y6fpyOs0CBSgpk5ZbUmPLSw1T34A4tLP3H5FQ88jtaLF6+jcJIgB
         X0ag==
X-Gm-Message-State: AFuF++niS2NGr40BCY+qSFMquzCtS7ceniIsCGY6XXBEwh9ElvRDUrBj
	NgG4lYBSu43LsQn0V6hNlD6AmGdfWq766jT1xqy+tmeCIqiIIqcS22OkkN9UGHTAST647C76vqF
	jxVDZ3TwTkqc8VglYj4CXkEzhn95946ZLGvI9BYYk1IjlfTKp05pG9ZZ9yQLsWp0ixq9jARGIPy
	TdAMTxAattV19kDGucihJ1fBYrSjKI8k+DA8oQ1RzClKX2LQTN83Ho8ScOZwIfr4BTYA==
X-Gm-Gg: AYBFou3Q6chXvn3haT7lSrHfFEJgApr3DDDggsyNaxaGAdcdHGRMRDAeR1563sK1rqH
	s831aTGEVK1coWSu1L1KTjNnfmDRUzasDecgDmxxZI7EzWjsOpDY6K1x/auLwrsg5y+RptpuRlb
	DWGapo6rRRR3zndAOaDrjah82g13h7RQVCS2Wox515u3rkI/ByIUh85MeO1w==
X-Received: by 2002:a05:620a:2686:b0:939:e6d9:b2c with SMTP id af79cd13be357-93c17ea5f77mr324089785a.16.1790062274660;
        Tue, 22 Sep 2026 00:31:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:939:e6d9:b2c with SMTP id
 af79cd13be357-93c17ea5f77mr324087185a.16.1790062274151; Tue, 22 Sep 2026
 00:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260728061706.3250521-1-Swati.ShivajiKoli@windriver.com> <881932.1790061186506103118@lists.yoctoproject.org>
In-Reply-To: <881932.1790061186506103118@lists.yoctoproject.org>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 15:31:02 +0800
X-Gm-Features: AcwNN1XoVXPm-cq_V5SBhI6of1qOmBFdE_uTZLO1VKQLTa3imzAp6aTDmDRTyaU
Message-ID: <CA+s=J=yOP_YpcnY8XOrjoF-P5VjXQqGmL1xwJ7W-jYq8Sv129A@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH 0/1] dpdk: fix do_configure failure on
 32-bit ARM (qemuarm) targets
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=bP6Ds/+Z c=1 sm=1 tr=0 ts=6ab22ec3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=iGHA9ds3AAAA:8 a=GNBG886qrM1pFBOolrMA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: scAOy1ldovRj4GHVeLYt7KDHXPN69DCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEwNiBTYWx0ZWRfXw013LT8oYJSe
 Br0AfKVBadmWxrMngzAg3lV6oMr7IOmlT2kmNLVw9tW9wec95HabSc1/pDBSU9TNknGeGnGb0oU
 VI4ijJrzfHHVJvFvJBOvACUxxPS1EAq38hCf2IHgF5vnPyKEn76oi65c5Nxfu9HtA5Cn4w1V9Is
 GEz5iOIzq6rfWh8GkexB0IaIfdNgEjSbsJbdWthm621Gujp1ze4QRZvNOVtHVfY49wqkE065bOH
 sYGHw4kY1GqkwUzc9H/zcNtqsLnTMxsi2WzWYORTg74y6/ZlTqdHS+VkP4qFo5tBABGHDGSO9Ot
 /IyFsWc4sSq38m5Ftmcjau/umSAnkNCDMy33sGROgDifvwPscN59tTv/s0VCnaHXpMPXzwKQb1x
 pA9kSBJNHpGdKWzUgpkqa+19PRlXq0G6yoinX0zWXHINw8sWKdNBPqGlJYuIS7l1QYscyzvNtu9
 0XZNvrjLjQ9Ghmm8oJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEwNiBTYWx0ZWRfXzWOEQGIl1xks
 bhHubfZldeqnnlU8JX5LSqPCAcoW9/iUszCgtuBe2hZXXt9TvHNLICXTElxuMWal+SmzQoqQ7V3
 TQcmr3Z9Ozamo29HPCKSiOquYJikgm0=
X-Proofpoint-GUID: scAOy1ldovRj4GHVeLYt7KDHXPN69DCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 07:31:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4928

On Tue, Sep 22, 2026 at 3:13=E2=80=AFPM Swati Koli via lists.yoctoproject.o=
rg
<Swati.ShivajiKoli=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
> Hi,
>
> Gentle ping on this patch. It has been waiting for review for some time.
>
> Could someone please take a look and provide feedback?

It was merged 8 weeks ago:
https://git.yoctoproject.org/meta-dpdk/commit/?id=3D6a59b0cd21084e33feb53b4=
f2d1310e49e1d4a83
?

Thanks,

Anuj

