Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14716D5C0C5
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 02:57:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12895.1765853848080167658
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 18:57:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=BVZqFpbd;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=TootX6gq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFNGX1E4174124
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	01el2SbguDArJulNrygdmlJCvFVubi1QdiG8WOezPHc=; b=BVZqFpbdvC5fMJd4
	B3Einqt2PLmMBY+hlMYXr80YxNhfNINh7F4pgLEGGC2DfauhAD17mXpED9Y17jDv
	n4PStOJsJ/Zo83jQoiCuASrwsUyX8wEy37VNGLVzL+CKAYnbnQOYYaQkGJNCoXGv
	Z62aF3VdG4I96Z6Kwc1Iy5ZsWPVtp/qz84RiLhzteeHw+uqA9vjR9gGsZvXPM2Ce
	ZrC9W05aBn6iKYYrZbrhmVpymyuD6m7rDpSJi6r7o4bvTLsVpQOutwRa5MVJP6Mk
	VOXgfU30noRe4J5r6xOs3rKi9POv3Z8oNiK4dZBbzwGOmjSAteT2Wmmldud2DmqM
	1u4Dcg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2ks029qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:57:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a2d8b7ea5so28396986d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 18:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765853846; x=1766458646; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01el2SbguDArJulNrygdmlJCvFVubi1QdiG8WOezPHc=;
        b=TootX6gqmPpTXeT0OjsZEIZh0yuTbjmN31xEsCNmVdIR1nZeQCyOJF/D2zxR5M94Qv
         2Yoe7Wn/uaGBiJ+4oRd6p0D7ho2119LCy5Bx+HNpvqKeJRzgthlcj98A0raDf/Ar0nof
         MD2RhLZCXe+6roesZ3Kv5VZhxrV4iTLurtBl2opV6CcKEpo44oEpDyGMZKYUBgdp8WNk
         Br/eNLO/ft2KCec21e06/GO/dDn5wcVvLRUrRMmuA1ZNOx/ezk5Q3T6Ec+Tdx8jSOiYk
         iM8rs4hu3fU0CfEg1byS1TtuS9LKY6oaL3nay2CDXhjcobZq7NZNy3urubKRl84/LVlE
         Ty7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853846; x=1766458646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01el2SbguDArJulNrygdmlJCvFVubi1QdiG8WOezPHc=;
        b=Cmf0O90p+K3EQAhd2NiHvFZ8fYJCnH0nYj2n1nWTf4s8B7Y0Vd56ZFVRys0zVHA2EU
         Hq7Y28j329uRcOoYBwfqwtQXveKjaoXdq10HP/Qv9vajae6IFLhmeXOtEfZpIfSgGAEx
         dC3lWS/N7vgwK+6RzPcLBxaDP23/WQZ9mwm3N/EVfSu7eocZvjx9U4fs0gLUGsor5LVq
         1kkSL4c9SWpDA6KuGQHmQdCszojBA+JGnNiiiio+Y65CiATkZ+TId85mBypNrtF/LVGQ
         uWTtfHJHPHO7CFfsnoZf6XzsC5c52fc9mVNK+HIU9TycsDb+Ci8V4uXlRwoKY63/B6lx
         rdsQ==
X-Gm-Message-State: AOJu0Yynqh3YGJuwP1KV0e9VbI4mCzcPE92IW7zKlHt32Vz26VcOubhf
	Kyn77WSZDDnAKaKpNVQdAVWCZ59KhC57gSYzYPjV3Tx0t7gw6jOSwT69ftLk5BcwPQtYc00QAk8
	RDnjPs8cRrDjihNZlGeLVChJVbNXmnxLuwemBcI/rNOf3c3yAlU0c03UmBiWnm5WFGfamkIIQjW
	U9KQU4tX2/t+hnmpSnqwGOkKDtEjPd1p8+9Ij/jDoiRiAuuPnuly8S
X-Gm-Gg: AY/fxX4OXBb3utudYOFrSer5ycC4aJbSgTPvRL6TL5Va8a3GEjNbsux4E9RcZI/CE7T
	mn47AaKAxbZqVM0cStShHtLKkXyTcq7t8ip+XztwRLDGn/b2vjAg4GP3hNoTi/UBRCTbyemjsPv
	RvCCIVB/rL9vc4h/p7C/2qKnyDGJ5ddt8Z18Y5MoOAvS7A4RaQEgzoHrNR8fNHvBuB
X-Received: by 2002:a05:6214:5285:b0:880:4c73:9e3b with SMTP id 6a1803df08f44-8887e42cd54mr184507466d6.15.1765853846442;
        Mon, 15 Dec 2025 18:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG61+VPGe8Gb6slBt4KwkovH7ujYWWLl7pXhzVh+OqTuKcTp+uDLXPj2EopynlKzISLkCfAB/b0mmLklypXwgs=
X-Received: by 2002:a05:6214:5285:b0:880:4c73:9e3b with SMTP id
 6a1803df08f44-8887e42cd54mr184507306d6.15.1765853845877; Mon, 15 Dec 2025
 18:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20251216024301.2972678-1-ruiqiang.hao@windriver.com>
In-Reply-To: <20251216024301.2972678-1-ruiqiang.hao@windriver.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 10:57:14 +0800
X-Gm-Features: AQt7F2ra6oba2SNCfGWP0IjjVW0en8quz6fVdThrCbYOUtIFSvEo_8GHi6kE2v4
Message-ID: <CA+s=J=yKgOGijWwvgr_tGSDczZRN+MnZmMinVJVf-r0OcveUXA@mail.gmail.com>
Subject: Re: [meta-dpdk][PATCH] dpdk: upgrade to 25.11
To: Ruiqiang Hao <ruiqiang.hao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vfArVAxAFKLnHn5qzTU6sU9950gLhnU-
X-Authority-Analysis: v=2.4 cv=eZcwvrEH c=1 sm=1 tr=0 ts=6940ca97 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=GK3HjB6jbOpafjXSG4IA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vfArVAxAFKLnHn5qzTU6sU9950gLhnU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDAyMyBTYWx0ZWRfX+zJu6OpoERig
 pldLhkQIQcccGKTM2WBJuX82JfJYxCsktLDK48G97q0qf0MTR9C3NNc9aKeENbiDsKZcUk5cPqX
 ZhjYtNzGmjwtHv4gtl2UD1WRhHBE+bHaAG5xt1qwTwDBcMflY8PDrZZS0TQgeBcpEmH819Tjl8p
 E4wNF2rS6oEkl27kNp3zQ3oZyU466ZXUl9oy/Rxk1kXquqYZb1cqPSZ9X/gYUBYQluqwUOA50Em
 OyH9f4SLmXd1tM5h4iZmuunmwvAHkQ4vD3iJYXSzEnLGIkI68InEg/3Lx9Q/9TMS5abAJcG/ByT
 cfX/41My4qXow1Tmp8EIDGXxPW6Dc2Zf9UZc8aLweC29WHJ3jTQ92W8Np4OICWKWxn9CCe4+acA
 GPfnr0KlK52wH/GlYpangE5JwvYkVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:57:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2793

On Tue, Dec 16, 2025 at 10:43=E2=80=AFAM Ruiqiang Hao
<ruiqiang.hao@windriver.com> wrote:
>
> From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
>
> Upgrade to dpdk 25.11 release.

What is this upgrading from? Isn't 25.11 the next LTS release? If yes,
please remove the older LTS recipe as well. Have you made any
noteworthy changes to the recipe or is it just copied from existing
24.11?

Please include more details in your commit message.

>
> Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
> ---
>  recipes-extended/dpdk/dpdk_25.11.0.bb | 71 +++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 recipes-extended/dpdk/dpdk_25.11.0.bb
>
> diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpd=
k/dpdk_25.11.0.bb
> new file mode 100644
> index 0000000..eb3a0d4
> --- /dev/null
> +++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
> @@ -0,0 +1,71 @@
> +include dpdk.inc
> +
> +SRC_URI +=3D " file://0001-config-meson-get-cpu_instruction_set-from-mes=
on-opti.patch"
> +
> +STABLE =3D "-stable"
> +BRANCH =3D "v25.11"
> +SRCREV =3D "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
> +S =3D "${WORKDIR}/git"
> +
> +def get_cpu_instruction_set(bb, d):
> +    import re
> +    march =3D re.search(r'-march=3D([^\s]*)', d.getVar('CC'))
> +    if march:
> +        return march.group(1)
> +    else:
> +        return "core2"
> +
> +EXTRA_OEMESON =3D " -Dexamples=3Dall -Dcpu_instruction_set=3D${@get_cpu_=
instruction_set(bb, d)} "
> +
> +COMPATIBLE_MACHINE =3D "null"
> +COMPATIBLE_HOST:libc-musl:class-target =3D "null"
> +COMPATIBLE_HOST:linux-gnux32 =3D "null"
> +
> +PACKAGECONFIG ??=3D " "
> +PACKAGECONFIG[afxdp] =3D ",,libbpf xdp-tools"
> +PACKAGECONFIG[libvirt] =3D ",,libvirt"
> +
> +RDEPENDS:${PN} +=3D "pciutils python3-core"
> +RDEPENDS:${PN}-examples +=3D "bash"
> +DEPENDS =3D "numactl python3-pyelftools-native"
> +
> +inherit meson pkgconfig
> +
> +INSTALL_PATH =3D "${prefix}/share/dpdk"
> +
> +do_install:append(){
> +    # remove  source files
> +    rm -rf ${D}/${INSTALL_PATH}/examples/*
> +
> +    # Install examples
> +    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
> +    for dirname in ${B}/examples/dpdk-*
> +    do
> +        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
> +            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
> +        fi
> +    done
> +
> +}
> +
> +PACKAGES =3D+ "${PN}-examples ${PN}-tools"
> +
> +FILES:${PN} +=3D " ${bindir}/dpdk-testpmd \
> +                ${bindir}/dpdk-proc-info \
> +                ${libdir}/*.so* \
> +                ${libdir}/dpdk/pmds-26.0/*.so* \
> +                "
> +FILES:${PN}-examples =3D " \
> +       ${prefix}/share/dpdk/examples/* \
> +       "
> +
> +FILES:${PN}-tools =3D " \
> +    ${bindir}/dpdk-pdump \
> +    ${bindir}/dpdk-test \
> +    ${bindir}/dpdk-test-* \
> +    ${bindir}/dpdk-*.py \
> +    "
> +
> +CVE_PRODUCT =3D "data_plane_development_kit"
> +
> +INSANE_SKIP:${PN} =3D "dev-so"
> --
> 2.46.2
>

