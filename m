Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.119])
 by mx.groups.io with SMTP id smtpd.web11.8062.1713429797011799691
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 01:43:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri97Fovtr0hkiDe+ilwYa801UniZs41mqBRGESQksDI=;
 b=JZjeI6ujcejKReLHTuN9/5qB9fMkwuOTKCH3TK/oG8WuV65afUsXVaIlVFva0ucRw9v9/dS81paUJntWW+bfO/Ldqv0TQFD++DaSSglKwB0Zl6jKT/jxMRFhoIF8IvFN+SF+wPn+S6FARtjXTWBMCln70RZ9JkQHhdY8LBNwjWFCbbrj+vxERJIcrPYRY4yHeSJ0bdWXlAdF5Lpg7ax6uCvnwOOkwvwbSLVbxl1FfvpApiFU7wLzQOXISovYjkUPD6F9elL3y0vdmnxvF+xbOrhCqYS7AKY4RQmj+hBJdnpxBe9y3WrqeR5mczOeWtmGZ3111XaJzUShNoqzMMhNvA==
Message-ID: <1d35ff20-9a01-42c9-b001-a7df1310e60c@theobroma-systems.com>
Date: Thu, 18 Apr 2024 10:43:10 +0200
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] enable stored U-Boot environment
References: <20240411011638.12198-1-twoerner@gmail.com>
 <bb4b9d20-b71d-4907-9df4-e3fbdd07275a@theobroma-systems.com>
 <20240417141930.GA11714@localhost>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417141930.GA11714@localhost>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
To: yocto-patches@lists.yoctoproject.org, Trevor Woerner <twoerner@gmail.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Trevor,

On 4/17/24 16:19, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend
>> b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> index f8378d91ce68..18702428a787 100644
>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> @@ -1,13 +1,29 @@
>>> +inherit rk-u-boot-env deploy
>>> +
>> Why is deploy suddenly added here? u-boot.inc already includes it so I don't
>> think it's warranted here.
> 
> Because this bbappend currently doesn't have a do_deploy() clause, and I'm
> about to add one, one that I want to be handled correctly wrt sstate and
> deploying, etc.
> 

The bbappend doesn't, but the original recipe does.

meta/recipes-bsp/u-boot/u-boot_2024.04.bb
-> meta/recipes-bsp/u-boot/u-boot.inc

inherit deploy

and there's a do_deploy there already, so we don't need to re-inherit it 
again in the bbappend I think?

>>>    FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>> -SRC_URI:append:rock-pi-e = " \
>>> +
>>> +# -- REMOVE AFTER 2024.04 --
>>> +# As of 2024.01 and 2024.04 U-Boot is unable to automatically read or
>> write
>>> +# its environment from/to the device from which it booted automatically.
>>> +# But patches are in master for rockchip devices to assume the user wants
>>> +# to use the boot media for the environment.
>>> +# Set the SRCREV to something on master, but don't set it to master to
>>> +# avoid churn.
>>> +# -- REMOVE AFTER 2024.04 --
>> U-Boot v2024.04 is merged in master, c.f. https://git.openembedded.org/openembedded-core/commit/meta/recipes-bsp/u-boot?id=c035655ed65b6333d87019677ba93d7899f42d9a
>>
>> For scarthgap, you can use meta-lts-mixin scarthgap/u-boot branch instead.
> 
> U-Boot v2024.04 still doesn't contain all the patches I need to get this
> working. The comment means "remove this with the release after 2024.04" not
> "once 2024.04 is being used this can be deleted".
> 

I should start reading comments with more care again, sorry for the 
noise. The next release is 2024.07, c.f. 
https://docs.u-boot.org/en/latest/develop/release_cycle.html

> Trying to find all the needed patches and back-porting them successfully, and
> testing all the builds and variants on the 6 boards that I have will take a
> ridiculous amount of time just to throw it all away with the next release
> after 2024.04? It's not worth it. I'll just set the SRCREV to something that I
> know works, update it post-2024.04 and get on with things.
> 

Up to you.

>>> +SRC_URI:append:rock-pi-e = " ${@bb.utils.contains('MACHINE_FEATURES',
>> 'rk-u-boot-env', '', ' \
>> SRC_URI:append:rock-pi-e:rk-u-boot-env = ""
>>
>> to avoid the bb.utils.contains which is difficult to read usually.
>>
>>> file://PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch \
>>> - file://PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch
>> \
>>> -	"
>>> + file://PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch
>> ', \
>>> +	d)} "
>>> +SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
>>> +
>>> +SRC_URI:append:rk-u-boot-env = " \
>>> +	file://rockchip-enable-environment-mmc.cfg "
>>>
>>>    # various machines require the pyelftools library for parsing dtb files
>>>    DEPENDS:append = " python3-pyelftools-native"
>>>    DEPENDS:append:rk3308 = " u-boot-tools-native"
>>>    DEPENDS:append:rock-pi-4 = " gnutls-native"
>>> +DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
>>>
>>>    EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
>>>    EXTRA_OEMAKE:append:rk3308 = " \
>>> @@ -40,3 +56,17 @@ do_compile:append:rock2-square () {
>>>    		cp ${B}/spl/${SPL_BINARY} ${B}
>>>    	fi
>>>    }
>>> +
>>> +do_compile:append:rk-u-boot-env() {
>>> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut
>> -d'=' -f2)"
>>> +	UBOOT_MMC_DEV="$(cat ${B}/.config | grep "^CONFIG_SYS_MMC_ENV_DEV=" |
>> cut -d'=' -f2)"
>> grep "pattern" file
>> instead of
>> cat file | grep "pattern"
>> ?
> 
> That's just a matter of taste. I prefer to see the file I'm querying first,
> then see what I'm doing with it. I guess that's just me.
> 

https://www.shellcheck.net/wiki/SC2002 /me shrugs

>>> +	echo "/dev/mmcblk${UBOOT_MMC_DEV}p5 0x0000 ${UBOOT_ENV_SIZE}" >
>> ${WORKDIR}/fw_env.config
>> I would really recommend to NOT use WORKDIR but B instead. The WORKDIR isn't
>> cleaned by bitbake for now, so you can have leftover.
> 
> Putting the file in WORKDIR ensures it gets picked up by the do_compile() of
> oe-core's u-boot.inc and therefore gets included in U-Boot's ${PN}-env
> package. Otherwise I'd have to tweak the U-Boot packaging myself.
> 

Reading the code, I guess you meant to say do_install instead. Thanks 
for pointing at this. This also means that nobody will be able to 
override this with their own fw_env.config from SRC_URI for example 
which I assume is the reason for reading it from WORKDIR. Not sure it's 
desirable but maybe?

Looking even more at the code, it seems WORKDIR is also used for the 
do_deploy of u-boot.inc. I'm actually wondering if this isn't breaking 
the sstate already? SHouldn't the do_deploy use the file from ${D} instead?

bitbake-getvar -r u-boot -f sstate-inputdirs --value do_install

returns None... so i'm certainly wrong somewhere :)

Been a long time since I played with sstate so I wouldn't be surprised 
if I completely missed on something or misunderstood/misremembered :)

>>
>>> +}
>>> +
>>> +do_deploy:append:rk-u-boot-env() {
>>> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut
>> -d'=' -f2)"
>>> +	mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o
>> ${WORKDIR}/u-boot.env
>>> +
>>> +	install -d ${DEPLOYDIR}
>>> +	install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
>> Just install at the top and then write the file directly to DEPLOYDIR? Or,
>> actually, create the file in do_compile if possible?
> 
> But I want this file handled correctly by do_deploy when sstate is being used?
> So don't I need to do this in the do_deploy task?
> 

Not sure to follow what's the concern about sstate? do_deploy sstate 
monitors everything in DEPLOYDIR so everything you install in there 
shall be under sstate?

For me do_deploy is for moving a file from one location to another, in 
DEPLOYDIR, nothing else. Everything that involves 
compilation/configuration is in do_compile/do_configure, so it's a bit 
odd to me to see a call to mkenvimage in do_deploy.

I guess you could have an issue with sstate if you use WORKDIR for 
u-boot.env since this wouldn't be under do_compile's sstate? But then 
just use ${B} for that instead?

Can you tell me a bit more about your concern here, I'm not getting the 
big picture yet :/

Cheers,
Quentin
