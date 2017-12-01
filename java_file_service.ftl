package ${packageName};

import com.dianping.poi.avatar.type.PageModel;
import com.dianping.poi.mybatis.utils.domain.PageList;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ${author}
 * @date ${date}
 */
@Service("${className?uncap_first}")
public class ${className}Impl implements ${className} {
    @Autowired
    private ${entityName}Mapper ${entityName?uncap_first}Mapper;

    @Autowired
    private ${entityName}Dao ${entityName?uncap_first}Dao;

    @Override
    public PageModel<${entityName}DTO> getListByPage(Map<String, Object> conditions, String orders, Integer page, Integer pageSize) {
        List<${entityName}> ${simpleName?uncap_first}List = ${entityName?uncap_first}Dao.getListByPage(conditions, orders, (page - 1) * pageSize, pageSize);
        PageList<${entityName}> pageList = (PageList<${entityName}>) ${simpleName?uncap_first}List;
        PageModel<${entityName}DTO> pageModel = new PageModel<>();
        pageModel.setOrders(orders);
        pageModel.setPage(page);
        pageModel.setPageSize(pageSize);
        pageModel.setRecordCount(pageList.getPaginator().getTotalCount());
        pageModel.setRecords(convert(${simpleName?uncap_first}List));
        return pageModel;
    }

    @Override
    public ${entityName}DTO getInstanceById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        ${entityName} ${simpleName?uncap_first} = ${entityName?uncap_first}Mapper.selectByPrimaryKey(id);
        return convert(${simpleName?uncap_first});
    }

    @Override
    public ${entityName}DTO add(${entityName}DTO ${simpleName?uncap_first}DTO) {
        if (${simpleName?uncap_first}DTO == null) {
            return null;
        }
        ${entityName} ${simpleName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(${simpleName?uncap_first}DTO, ${simpleName?uncap_first});
        ${simpleName?uncap_first}.setStatus(0);
        ${entityName?uncap_first}Mapper.insertSelective(${simpleName?uncap_first});
        return getInstanceById(${simpleName?uncap_first}.getId());
    }

    @Override
    public ${entityName}DTO update(${entityName}DTO ${simpleName?uncap_first}DTO) {
        if (${simpleName?uncap_first}DTO == null || ${simpleName?uncap_first}DTO.getId() == null || ${simpleName?uncap_first}DTO.getId() <= 0) {
            return null;
        }
        ${entityName} ${simpleName?uncap_first} = new ${entityName}();
        BeanUtils.copyProperties(${simpleName?uncap_first}DTO, ${simpleName?uncap_first});
        ${simpleName?uncap_first}.setUpdatetime(new Date());
        ${entityName?uncap_first}Mapper.updateByPrimaryKeySelective(${simpleName?uncap_first});
        return getInstanceById(${simpleName?uncap_first}.getId());
    }

    @Override
    public int delete(Integer id) {
        if (id == null || id <= 0) {
            return 0;
        }
        return ${entityName?uncap_first}Mapper.deleteByPrimaryKey(id);
    }

    private List<${entityName}DTO> convert(List<${entityName}> ${simpleName?uncap_first}List) {
        return Optional.of(${simpleName?uncap_first}List)
                .orElse(Collections.emptyList())
                .stream()
                .map(this::convert)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    private ${entityName}DTO convert(${entityName} ${entityName?uncap_first}) {
        if (${entityName?uncap_first} == null) {
            return null;
        }
        ${entityName}DTO ${entityName?uncap_first}DTO = new ${entityName}DTO();
        BeanUtils.copyProperties(${entityName?uncap_first}, ${entityName?uncap_first}DTO);
        return ${entityName?uncap_first}DTO;
    }
}
