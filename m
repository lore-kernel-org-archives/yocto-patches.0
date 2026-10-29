Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5657.1793253199974992553
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 22:53:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD3rtbj3uJql2EAAA--.85S3;
	Thu, 29 Oct 2026 13:51:32 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWqP3uJqlSQnAA--.25976S2;
	Thu, 29 Oct 2026 13:50:07 +0800 (CST)
Message-ID: <eda36dba-87a9-4760-a0d5-b6db087d4ada@cetc.com.cn>
Date: Thu, 29 Oct 2026 13:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] refpolicy: allow
 configuring policy booleans
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 Wenwen Fu <wenwfu@qti.qualcomm.com>
References: <20260826045540.1390035-1-wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260826045540.1390035-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWqP3uJqlSQnAA--.25976S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYPCmrh+hMRRAABs3
X-CM-DELIVERINFO: =?B?yWh8C6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOKAVCGp4YV81L5jQR5ux1rh3apPMiyot8sYdOODjKMrHPTBjvzVke2Yss37TVBjHV5QA
	QxV6l9gTyjtqpAgP/cbNyyXeBYcrq36Ina3b+uP39V5dJHsRK3ZBW9UXee+98g==
X-Coremail-Antispam: 1Uk129KBj93XoWxAFykXF1xKFW8tw4fCrykWFX_yoW5ury3pw
	sxGF9xAasrXFyxGrn7Gw4rWrnYkas7Wa17Zry7GFykAw1UC3Z7uw10qryxXFW8CrWfXr17
	J3W5uF43Ga1UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrJv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	126r1DMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7zBTDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 05:53:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5182

Merged

Regards,
Qi

On 8/26/26 12:55, Wenwen Fu via lists.yoctoproject.org wrote:
> Changing boolean or tunable defaults currently requires layers to patch
> refpolicy sources. This does not scale when a distribution maintains
> several policy-specific settings.
>
> Add POLICY_BOOLEANS as a space-separated list of name=value settings.
> Apply the settings after generating booleans.conf and fail the build for
> invalid entries or names not provided by the selected policy.
>
> Document the new variable in the layer README.
>
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
>   README                                        | 12 ++++++
>   .../refpolicy/refpolicy_common.inc            | 37 +++++++++++++++++++
>   2 files changed, 49 insertions(+)
>
> diff --git a/README b/README
> index ae011f3..4a13669 100644
> --- a/README
> +++ b/README
> @@ -47,6 +47,18 @@ to be tailored for your environment.
>   e.g. PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mls"
>   
>   
> +Configuring policy booleans and tunables
> +----------------------------------------
> +Policy boolean and tunable defaults can be changed at build time with the
> +POLICY_BOOLEANS variable.  Entries use a space-separated name=value format,
> +and values must be either true or false.  For example:
> +
> +POLICY_BOOLEANS = "secure_mode=true allow_execmem=false"
> +
> +The refpolicy build fails if an entry has an invalid format or names a boolean
> +or tunable that is not provided by the selected policy.
> +
> +
>   Using different init manager
>   ----------------------------
>   By default selinux enabled images coming up with "sysvinit" as init manager,
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index d241343..f9a55bc 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -117,6 +117,10 @@ POLICY_MLS_SENS ?= "16"
>   POLICY_MLS_CATS ?= "1024"
>   POLICY_MCS_CATS ?= "1024"
>   
> +# Space-separated policy boolean/tunable settings in name=value format.
> +# Values must be either true or false.
> +POLICY_BOOLEANS ?= ""
> +
>   EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
>       TYPE=${POLICY_TYPE} \
>       DISTRO=${POLICY_DISTRO} \
> @@ -153,11 +157,44 @@ disable_policy_modules() {
>       done
>   }
>   
> +set_policy_booleans() {
> +    for setting in ${POLICY_BOOLEANS}; do
> +        name="${setting%%=*}"
> +        value="${setting#*=}"
> +
> +        if [ "${name}" = "${setting}" ]; then
> +            bbfatal "Invalid POLICY_BOOLEANS entry: ${setting}"
> +        fi
> +
> +        case "${name}" in
> +            ""|*[!A-Za-z0-9_]*)
> +                bbfatal "Invalid policy boolean name: ${name}"
> +                ;;
> +        esac
> +
> +        case "${value}" in
> +            true|false) ;;
> +            *)
> +                bbfatal "Invalid value for ${name}: ${value}"
> +                ;;
> +        esac
> +
> +        if ! grep -q "^${name}[[:space:]]*=" \
> +                "${S}/policy/booleans.conf"; then
> +            bbfatal "Unknown policy boolean or tunable: ${name}"
> +        fi
> +
> +        sed -i "s/^\(${name}[[:space:]]*=[[:space:]]*\).*/\1${value}/" \
> +            "${S}/policy/booleans.conf"
> +    done
> +}
> +
>   do_compile() {
>       if [ -f "${WORKDIR}/modules.conf" ] ; then
>           cp -f ${WORKDIR}/modules.conf ${S}/policy/modules.conf
>       fi
>       oe_runmake conf
> +    set_policy_booleans
>       disable_policy_modules
>       oe_runmake policy
>   }

