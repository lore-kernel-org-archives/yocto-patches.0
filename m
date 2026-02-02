Return-Path: <denis@denix.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12049E7316F
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 19:17:21 +0000 (UTC)
Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61598.1770059838652253099
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 11:17:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id BF65C40CB4;
	Mon,  2 Feb 2026 19:17:17 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3eubXZuy5_i; Mon,  2 Feb 2026 19:17:17 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-87-159.washdc.fios.verizon.net [100.15.87.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 2193E40B13;
	Mon,  2 Feb 2026 19:17:05 +0000 (UTC)
Received: by mail.denix.org (Postfix, from userid 1000)
	id 5386517839E; Mon,  2 Feb 2026 14:17:04 -0500 (EST)
Date: Mon, 2 Feb 2026 14:17:04 -0500
From: Denys Dmytriyenko <denis@denix.org>
To: hongxu.jia@windriver.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Halstead <mhalstead@linuxfoundation.org>,
	yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>,
	"Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
	Robert Yang <liezhi.yang@windriver.com>,
	Randy MacLeod <Randy.MacLeod@windriver.com>,
	Mark Asselstine <mark.asselstine@windriver.com>,
	"Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
	"Chen, Qi" <Qi.Chen@windriver.com>
Subject: Re: [Openembedded-architecture] Running Large Language Models
 Locally -- Contribute meta-ollama to Yocto
Message-ID: <20260202191704.GT11121@denix.org>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 19:17:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3171

On Fri, Jan 30, 2026 at 01:20:42PM +0800, hongxu via lists.openembedded.o=
rg wrote:
> Hi all,
>=20
> ChatGPT[1] has been popular for several years, perhaps you also know
> Deepseek[2]
> which is an open-source language model and run locally.
>=20
> The local runner to run Deepseek is Ollama[3]. It lets you download and=
 run
> large language models (LLMs) on your own machine, without relying on
> cloud-hosted services.
>=20
> That is good for Yocto, so I integrate ollama to Yocto-based Linux syst=
em,
> build from source, offline install and deploy.
>=20
> For the convenience of review, show it on my github [4] temporary,

I had a question about your contribution policy, but I checked your READM=
E and=20
MAINTAINERS that mention sending patches to either yocto@ or yocto-patche=
s@


> - The BUILD.md [5] provides the steps to build and run on CPU by defaul=
t,
> - The BUILD-cuda-x86-64.md [6] provides the steps to build and run
> on NVIDIA GPU
> =A0 with CUDA for x86-64
>=20
> And now contribute meta-ollama to Yocto, the layer provides:
>=20
> - Recipe ollama: provides application ollama.

Will you be open to llama.cpp client besides ollama?


> =A0 It supports to run on CPU by default. And optional on NVIDIA GPU
> with CUDA
>=20
> - Recipe llama3.2-1b and llama3.2-3b: the large language model by Meta =
[7]
>=20
> - Recipe gemma2-9b and gemma2-2b: the large language model by Google [8=
]
>=20
> - Recipe deepseek-r1-7b and deepseek-r1-1dot5b, the large language
> model by Deepseek [9]

Will you be open to Qwen3 LLM by Alibaba? GPT LLM by OpenAI?


> - Recipe nvidia-open-gpu-kernel-module: the kernel module for NVIDIA GP=
U
>=20
> - Recipe nvidia-driver-x86-64: provides firmware for NVIDIA kernel modu=
le,
> =A0 CUDA library and application nvidia-smi for x86-64 BSP. NOTE, no so=
urces,
> =A0 only binaries from NVIDIA [10], license is Proprietary [11]
>=20
> - dynamic-layers/meta-tegra: customize meta-tegra to support CUDA for x=
86-64

I'm not going to ask about other architectures for now...

--=20
Denys

