Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1414D1088E75
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 04:36:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4028.1773894973296599389
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 21:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=VooAt5Cx;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=gpWM0Jta;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IMHoVS1928645
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 04:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wuQHOU0Vga29g/LrtET2zmbMTljmHa8veVAres+4RtQ=; b=VooAt5Cxzy4EuuME
	1vwfi/CNrje2J0zNjiORb9G6Xjxi5Qwp8qVJgspDr8OvpQynAqksmenQ0NJLEKG/
	0ytDTo2ioqWqO1DEHiR85bItwSbW9oVYOA1U6ADsm873k6JP6ik3oPa5AsOE+9RG
	4KYr2c4dAmLBbDV8GZjZcWXvqgKZNYgAO3jZQPlfOR9V3zDMoO7l1BnZnPQn1Ftw
	uvJ75xcbSzORYyuONMJv3NhWxJvVqu210Hlq4q4MsWTfDGqzXMGpy2Yu+y1hAeG9
	9ixFNmwT/YpXf3qyJ/PdyeZeGF5F/KjZNcCMt6/198+YdApIsVzez7leod2/IhUe
	2PGtgw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyut1b0vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 04:36:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093787e2fdso76450201cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 21:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773894971; cv=none;
        d=google.com; s=arc-20240605;
        b=iRFPwoxPLq3aatLvGiC4q2NuTAerEvEPp31WT5mqT81yw+N1eFEaPwmK6/Y0ZuRS9O
         4+ZjINvTWjg1bN6uXP76OLTCWJ7mx6Rs7COilgxhUpjiTSZLVceBoMITSp7ZzcgUyTvD
         pMupe1gp9eDKZoSPGAxtLcR2bbbTW56OL1wP1Syp0VEKLGHjemdWz++mpDogQxta2NSN
         5xCAGhvEdbzsxnrwYiv7kbn0N9yn+P8CE8ulgYt7JdMRnWpu2+wxP9wlPqMI1AIdO8LQ
         bZC7ikJ+e5gPgerRZHLM4tcJ21yiLtNrbT2ei4KD72dnDRXhcjyPgByvz6DZxDdX851f
         9UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuQHOU0Vga29g/LrtET2zmbMTljmHa8veVAres+4RtQ=;
        fh=XjjaneAJevcibkqEWEdAgdVKTQUo9XKdIF3ZmB+GC5c=;
        b=fKdIIXsgY9CCqcmsP6mYkoYw1Ro0QqcyMB1iZKlp+SrvDwWv9KviVYSbJIYLdjoekx
         7fcjbXSvZ2vaLHpCS7tTYNaic37Saw5rnhbIbM5m3NiDGrpfXdmAFiGd9uI9+yX0vnJ1
         yiPOC6pfwMXOQ9V23uZRiSQ7DXjoxsw1Z6q3FwbV7Mu14iKrt5bv9Szp+A1tyjSp11Ce
         E3sRAbxpgpJE7bfyRFs80eQsujYYGh+J/7YAv0JWiAWXwye0vSvje6HMzRJ2mPVPZTth
         JKYhIHu+nh0DSANh5OUFNnvQyd4sNrBcFMl9bcYx+3fJ3BogvsJi8Co4mTfllPrOVjEn
         wdCw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773894971; x=1774499771; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuQHOU0Vga29g/LrtET2zmbMTljmHa8veVAres+4RtQ=;
        b=gpWM0JtaM+xvi9XAk/1D6EFkAj/tqcysce4CYNoXp6O/n0cdHcktmoOk9/NyGGzwQL
         CYk8xjGiZ6aKZijN1VvzrXVpYz5vFZP9uRO6abB0lXnKu5hNdWx17GU/8OdE4NX3cr8R
         /ZyxWd8geVymQ+UaleI6WYxslWt+0cYBqAJfHjgC0MiXYyQjUB+XrJjaSuF6mrcTr/zM
         w6fXNPs1j0znFT0HdkVSIbeyAI9Xh1sFYWWiNLLqa2c6TXo016CvyE3J+Gb6gpjLlC9S
         qQU3Um1u8wZDbUCEEJzs1c5PqlBPcRxyMmwAjCYF+fvl14zXgOVv9+ILFCxdKfjo6RUs
         AUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773894971; x=1774499771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuQHOU0Vga29g/LrtET2zmbMTljmHa8veVAres+4RtQ=;
        b=FoqysX16SQ00BDbMs4Qp4ebsRBfmq+PQ+9FHpRLhjFBSb8W8S3/Uo2GT0AZpDbdDEy
         h7KZ2X2DPxEcvhCzbnGYHx4NYyK7jQ1F1XJdHgBti6c5yCZe4+1l3mhn5BbFl3iD2Hkv
         ASdQ0pz4kpyLITfV3PsY7LXRULCV469CQO0eGF8mE6XKTkb7D8CwPWt587UcBpr5SaD2
         8yDgB0U0aGVZzWkW9I1/Uz+0XR7Nlb7eORe2TEcqVkf+cA4ZXWCPBs6YC+WHF3bxhLtm
         MgCQQNDJsiqf9hRdDudCRVzE6+QvI6Afo51Dwt9HwlU09yODT7ctnxmlGMg9/mhqfzR0
         JxFQ==
X-Gm-Message-State: AOJu0YzqWMJDVHsShfQkjNmw1v6ZGn0JHk+HKvmute8qqj5jvAVbDydj
	wUKUQoyQ+9RnjtOig3kWs+sAo6ieIsDS0wED6dgsp7f3d6k0696VjARlkSQ3iHE0OoH6RFFOIms
	03G80lXK7R8pIN85nLF7CD28WPcdMMQtYw6XtcO/u1XMQVmFuzABIdawbd3Rf4n1UdhRDuHHy7w
	AO0oZe/NLV0ve4oAqCp8lLfW/sdfGqrCZi8byscGldm3XGbibhtGFt/1cu0puZf5apbA==
X-Gm-Gg: ATEYQzxVNbIGLXpfPsET7EvyoKZpZTTEzmsmBgXGcmEnppzp6BL9aGOW4yImlrLKTJY
	bONtmIpfhctQc/MsJSpQ49DHnOMyzF+cygW7JSWZ4ONgBO1Ad6QEddP6gszCp1lSaoUjhYhxC9X
	yojmqWu+hKRrWX+uUfP8tUR3cn3M1bAaYftw9BppmQDmqyRn5sapQ5FqpUUS7hDgyowad6Tqh6A
	twp
X-Received: by 2002:a05:622a:d0:b0:50b:2eee:4b3c with SMTP id d75a77b69052e-50b2eee68d9mr585441cf.15.1773894971318;
        Wed, 18 Mar 2026 21:36:11 -0700 (PDT)
X-Received: by 2002:a05:622a:d0:b0:50b:2eee:4b3c with SMTP id
 d75a77b69052e-50b2eee68d9mr585291cf.15.1773894970792; Wed, 18 Mar 2026
 21:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260316121133.66539-1-youenn.lejeune@savoirfairelinux.com>
In-Reply-To: <20260316121133.66539-1-youenn.lejeune@savoirfairelinux.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:35:59 +0800
X-Gm-Features: AaiRm51zLIU5pV6D3q72hr1FqnVNCl67Em74cbkkvbQce0hLzEzyjmvJNevECps
Message-ID: <CA+s=J=x6j1YGK6E5+ncgr2PLcS1hqiRENwPdrj9kUJFgvBXyVA@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] dpdk: replace CVE_CHECK_IGNORE with CVE_STATUS
To: yocto-patches@lists.yoctoproject.org
Cc: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>,
        Erwann Roussy <erwann.roussy@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: xa8ZiCIzzwfcGX3VCmZr9SJGGfQ-qEgj
X-Authority-Analysis: v=2.4 cv=ModfKmae c=1 sm=1 tr=0 ts=69bb7d3c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=iGHA9ds3AAAA:8 a=aRxQL1JOAAAA:8 a=EUspDBNiAAAA:8
 a=u7RCqbbcbkqKrwhgRJQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=lBRdisTmIr2YKkuu8atg:22
X-Proofpoint-ORIG-GUID: xa8ZiCIzzwfcGX3VCmZr9SJGGfQ-qEgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAzMyBTYWx0ZWRfX7NJSXfXsHcL3
 cdN3vRhD8bFqM6vgrNdJvtt7jdlKVJpO+x9Oz8LsZHZs+TSnQFq8giHPVeu0skUBqK6DpmlYpEv
 D3jSygTtnbjT+E79CoCGpxHNzuD+BJKhg45Um7hOkMdiXh9raF2415cHyTNG1HbQ8l6eslAPFd3
 89fF6dpqv6OrPV+75aoGKCE2v/rZYZFiskX2wAnv//MTedhDqoBdy3Njz5OUjG0G3VNnWE9T+CQ
 24B/XciyRI6giiM2YudyxyH4AwPr55svPZ3iuLRb1x1F/wXYf4ABKiA38vsZM5x3prhfKFXurI/
 2UJ/JFXZUA+b3sjsOoN7ZD/n/H4X2d8oArJEXj5EEMYB2OJJd549FlW+3Xs1TOYCbsEVBtDFF93
 SQykUHmMwAE6Jvi1HFYgj6RD4UZCtYStLDhiOY6YpHaS0XfseIW5CJY191IbBdZj4LRZSNPaVFx
 AxFP3LN8BFMPo3AhQog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190033
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 04:36:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3518

On Mon, Mar 16, 2026 at 8:12=E2=80=AFPM Youenn Le Jeune via
lists.yoctoproject.org
<youenn.lejeune=3Dsavoirfairelinux.com@lists.yoctoproject.org> wrote:
>
> CVE_CHECK_IGNORE is obsolete since Yocto 4.3 and has been
> replaced by CVE_STATUS.
>
> Reviewed-by: Erwann Roussy <erwann.roussy@savoirfairelinux.com>
> Signed-off-by: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>
> ---
>  recipes-extended/dpdk/dpdk_22.11.11.bb | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/recipes-extended/dpdk/dpdk_22.11.11.bb b/recipes-extended/dp=
dk/dpdk_22.11.11.bb
> index f2db074..8d5d248 100644
> --- a/recipes-extended/dpdk/dpdk_22.11.11.bb
> +++ b/recipes-extended/dpdk/dpdk_22.11.11.bb
> @@ -9,14 +9,8 @@ BRANCH =3D "22.11"
>  SRCREV =3D "ff0626010952913655a6df4c4e12fc386bea7fe4"
>  S =3D "${WORKDIR}/git"
>
> -# CVE-2021-3839 has been fixed by commit 4c40d30d2b in 21.11.1
> -# NVD database is incomplete
> -# CVE-2022-0669 has been fixed by commit 6cb68162e4 in 21.11.1
> -# NVD database is incomplete
> -CVE_CHECK_IGNORE +=3D "\
> -    CVE-2021-3839 \
> -    CVE-2022-0669 \
> -"
> +CVE_STATUS[CVE-2021-3839] =3D "fixed-version: Fixed by commit 4c40d30d2b=
 in 21.11.1, NVD database is incomplete"
> +CVE_STATUS[CVE-2022-0669] =3D "fixed-version: Fixed by commit 6cb68162e4=
 in 21.11.1, NVD database is incomplete"
>

I'm assuming this is for scarthgap branch.

Perhaps this should be removed completely since the data seems to show
22.11 is not affected. We also had merged
https://git.yoctoproject.org/meta-dpdk/commit/?id=3D66da651100b8f7f3b2d059e=
48bf646cb1b1b06b7
some time back. Can you please check if these CVEs still show up
without these ignores?

>  # kernel module is provide by dpdk-module recipe, so disable here
>  EXTRA_OEMESON =3D " -Denable_kmods=3Dfalse \
> --
> 2.53.0
>
>
>
> ------------
> Links: You receive all messages sent to this group.
> View/Reply Online (#3472): https://lists.yoctoproject.org/g/yocto-patches=
/message/3472
> Mute This Topic: https://lists.yoctoproject.org/mt/118343302/3616702
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1321632=
3/3616702/1570666242/xyzzy [anuj.mittal@oss.qualcomm.com]
> ------------
>
>

