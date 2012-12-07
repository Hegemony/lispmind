<#-- input -->
<#macro input
    name
    type="text"
    class=""
    id=""
    value=""
    dataParams=""
    disabled='false'
    label="xxx"
>
    <#local complexType=['checkbox', 'radio', 'textarea'] >
    <#if name?exists>
        <#if id == "">
            <#local id=name>
        </#if>

        <#if !complexType?seq_contains(type) >
            <@buildSampleItem 
                name=name
                id=id
                type=type
                class=class
                value=value
                dataParams=dataParams
                disabled=disabled
                label=label
            />
        </#if>
    </#if>
</#macro>

<#-- checkbox -->
<#macro checkbox
    source
    name
    textKey="name"
    valueKey="id"
    checkedValue=""
    checkedKey="checked"
    class=""
    disabled=""
    type="checkbox"
>
    <@buildItem
        source=source
        name=name
        textKey=textKey
        valueKey=valueKey
        checkedValue=checkedValue
        checkedKey=checkedKey
        class=class
        disabled=disabled
        type=type
    />
</#macro>

<#-- radio -->
<#macro radio
    source
    name
    textKey="name"
    valueKey="id"
    checkedKey="checked"
    checkedValue=''
    class=""
    disabled=""
    type="radio"
>
    <@buildItem
        source=source
        name=name
        textKey=textKey
        valueKey=valueKey
        checkedKey=checkedKey
        checkedValue=checkedValue
        class=class
        disabled=disabled
        type=type
    />
</#macro>

<#-- select -->
<#macro select
    source
    name
    textKey="name"
    valueKey="id"
    selectedKey="selected"
    empty='false'
    selectedValue=''
    class=""
    disabled=""
    type="select"
>
    <@buildItem
        source=source
        name=name
        textKey=textKey
        valueKey=valueKey
        empty=empty
        checkedKey=selectedKey
        checkedValue=selectedValue
        class=class
        disabled=disabled
        type=type
    />
</#macro>


<#-- build input type contain (text password hidden submit reset)-->
<#macro buildSampleItem 
    name
    type="text"
    class=""
    id=""
    value=""
    dataParams=""
    disabled='false'
    label="xxx"
>
    <#if label != "">
        <label for=${name}>${label}：</label>
    </#if>
    <input type="${type}" name="${name}" id="${id}"
    <#if value != "">
        value="${value}"
    </#if>
    <#if class != "">
        class="${class}"
    </#if>
    <#if dataParams != "">
        dataParams="${dataParams}"
    </#if>
    <#if disabled == 'true'>
        disabled="${disabled}"
    </#if>
    />
</#macro>

<#-- build radio checkbox select-->
<#macro buildItem
    source
    name
    id=""
    textKey="name"
    valueKey="id"
    textKey=""
    empty='false'
    checkedValue=""
    checkedKey="checked"
    class=""
    disabled=""
    type="checkbox"
>
    <#if source?exists && name?exists>
        <#if type == "select">
            <#if !id?exists || id == "">
                <#local id=name>
            </#if>
            <select name="${name}" id="${id}">
            <#if empty?is_hash>
                <#list empty?keys as k>
                    <option value="${k}">${empty[k]}</option>
                </#list>
            </#if>
        </#if>
        <#if source?is_hash>
            <#list source?keys as k>
                <#if (checkedValue?is_sequence &&  checkedValue?seq_contains(k)) ||
                    ((checkedValue?is_string || checkedValue?is_number)  && checkedValue?string == k?string)    
                >
                    <#local checked="true">
                <#else>
                    <#local checked="false">
                </#if>
                <#if type == "select">
                    <option value="${k}" <#if checked == "true"> selected="selected" </#if> >${name}</option>
                <#else>
                    <input type="${type}" name="${name}" id="${k}"
                    <#if checked == "true">
                        checked="checked"
                    </#if>
                    <#if disabled == "true">
                        disabled="true"
                    </#if>
                    <#if class != "">
                        class="${class}"
                    </#if>
                    >
                    <label for="${k}">${source[k]}</label>
                </#if>
            </#list>
            <#if type == "select">
                </select>
            </#if>
        </#if>
        <#if source?is_sequence>
            <#list source as item>
                <#if item?is_hash>

                    <#if (item[checkedKey]?exists && item[checkedKey]?string == "true") || 
                        (checkedValue?is_sequence &&  checkedValue?seq_contains(item[valueKey])) ||
                        ((checkedValue?is_string || checkedValue?is_number)  && checkedValue?string == item[valueKey]?string)    
                    >
                        <#local checked="true">
                    <#else>
                        <#local checked="false">
                    </#if>
                    <#if type == "select">
                        <option value="${item[valueKey]}" <#if checked == "true"> selected="selected" </#if> >${item[textKey]!""}</option>
                    <#else>
                        <input type="${type}" name="${name}" id="${item[valueKey]}"
                        <#if checked == "true">
                            checked="checked"
                        </#if>
                        <#if disabled == "true">
                            disabled="true"
                        </#if>
                        <#if item["class"]?exists && item["class"] != "">
                            class="${item['class']}"
                        </#if>
                        >
                        <label for="${item[valueKey]}">${item[textKey]}</label>
                    </#if>
                </#if>
            </#list>
            <#if type == "select">
                </select>
            </#if>
        </#if>
	</#if>
</#macro>

<#macro year
    name
    id=""
    from=""
    label="年份"
    to=""
>
    <@time 
        name=name
        id=id
        from=from
        label=label
        to=to
        type="year"
    />
</#macro>

<#macro mouth 
    name
    id=""
    from=""
    label="月份"
    to=""
    type="mouth"
>
    <@time 
        name=name
        id=id
        from=from
        label=label
        to=to
        type="mouth"
    />
</#macro>

<#-- time contains (year mouth hour minute) -->
<#macro time
    name
    id=""
    from=""
    label="年份"
    to=""
    type="year"
>
    <#if name?exists>
        <#if id == "">
            <#local id=name>
        </#if>
        <#if label != "false">
            <#if type == "mouth">
                <#local label = '月份'>
            </#if>
            <label for="${id}">${label}：</label>
        </#if>
        <select name="${name}" id="${id}">
        <#if type == "year">
            <#if from == "">
                <#local from = ".now?string(YYYY)"> 
            </#if>
            <#if to == "">
                <#local to = ".now?string(YYYY)"> 
            </#if>
            <#list from?number..to?number as y>
                <option value="${y}">${y}</option>
            </#list>
        <#else>
            <#if from == "">
                <#local from = ".now?string(MM)"> 
            <#else>
                <#if (from?number > 12) >
                    <#local from = 11>
                </#if>
                <#if (from?number < 1) >
                    <#local from = 1 >
                </#if>
            </#if>
            <#if to == "">
                <#local to = ".now?string(MM)"> 
            <#else>
                <#if (to?number > 12) >
                    <#local to = 12>
                </#if>
                <#if (to?number < 1) >
                    <#local to = 1 >
                </#if>
            </#if>
            <#local month = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月     ', '十月', '十一月', '十二月'] >
            <#list from?number..to?number as m>
                <option value="${m}">${month[m-1?number]}</option>
            </#list>
        </#if>
        </select>
    </#if>
</#macro>
