package ${packageName};

import com.nengjun.avatar.face.type.PageModel;
import com.nengjun.avatar.face.type.Result;
import com.nengjun.avatar.face.utils.ResultUtil;
import com.nengjun.avatar.face.utils.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @author Henry
 * @date 2017/7/13
 */
@RestController
@RequestMapping("/api")
public class ${className} {
    @Autowired
    private ${entityName}Mapper ${entityName?uncap_first}Mapper;

    @GetMapping("/${simpleName?uncap_first}s")
    public Result list(
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
            @RequestParam(value = "pageSize", required = false, defaultValue = "20") Integer pageSize
    ) {
        PageModel<${entityName}> pageModel = new PageModel<>();
        pageModel.setPageAndPageSize(page, pageSize);
        List<${entityName}> ${simpleName?uncap_first}List = ${entityName?uncap_first}Mapper.selectByPage(pageModel);
        pageModel.setList(${simpleName?uncap_first}List);
        return ResultUtil.success(pageModel);
    }

    @GetMapping("/${simpleName?uncap_first}s/{id}")
    public Result show(@PathVariable("id") Integer id) {
        Validate.idValid("id", id);
        ${entityName} ${simpleName?uncap_first} = ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
        Validate.hasRecord("id", id, ${simpleName?uncap_first});
        return ResultUtil.success(${simpleName?uncap_first});
    }

    @PostMapping("/${simpleName?uncap_first}s")
    public Result create(@Valid @RequestBody ${entityName} ${entityName?uncap_first}, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Validate.isRecord(true, bindingResult.getFieldError().getDefaultMessage());
        }
        ${entityName} ${simpleName?uncap_first} = new ${entityName}();
        copyProperties(${entityName?uncap_first}, ${simpleName?uncap_first});
        ${entityName?uncap_first}Mapper.insert(${simpleName?uncap_first});
        return ResultUtil.success(${simpleName?uncap_first});
    }

    @PutMapping("/${simpleName?uncap_first}s/{id}")
    public Result update(@PathVariable("id") Integer id, @Valid @RequestBody ${entityName} ${entityName?uncap_first}, BindingResult bindingResult) {
        Validate.idValid("id", id);
        if (bindingResult.hasErrors()) {
            Validate.isRecord(true, bindingResult.getFieldError().getDefaultMessage());
        }
        ${entityName} ${simpleName?uncap_first} = ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
        Validate.hasRecord("id", id, ${simpleName?uncap_first});
        copyProperties(${entityName?uncap_first}, ${simpleName?uncap_first});
        ${entityName?uncap_first}Mapper.updateByPrimaryKey(${simpleName?uncap_first});
        return ResultUtil.success(${simpleName?uncap_first});
    }

    @DeleteMapping("/${simpleName?uncap_first}s/{id}")
    public Result delete(@PathVariable("id") Integer id) {
        Validate.idValid("id", id);
        return ResultUtil.success(${entityName?uncap_first}Mapper.deleteByPrimaryKey(id));
    }

    private void copyProperties(${entityName} ${entityName?uncap_first}, ${entityName} ${simpleName?uncap_first}) {
        ${simpleName?uncap_first}.setName(${entityName?uncap_first}.getName());
        ${simpleName?uncap_first}.setAltName(${entityName?uncap_first}.getAltName());
        ${simpleName?uncap_first}.setContent(${entityName?uncap_first}.getContent());
    }
}
